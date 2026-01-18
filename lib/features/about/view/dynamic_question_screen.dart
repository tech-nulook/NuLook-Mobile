import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nulook_app/common/app_snackbar.dart';
import 'package:nulook_app/core/routers/app_navigator.dart';
import 'package:nulook_app/core/routers/app_router_constant.dart';
import '../../../common/widgets/no_data_widget.dart';
import '../../home/view/advanced_drawer.dart';
import '../bloc/signup_cubit.dart';
import '../model/answer_request_model.dart';
import '../model/question.dart';

class DynamicQuestionScreen extends StatefulWidget {
  const DynamicQuestionScreen({super.key});

  static Widget getRouteInstance() => MultiBlocProvider(
    providers: [BlocProvider(create: (context) => SignupCubit())],
    child: DynamicQuestionScreen(),
  );

  @override
  State<DynamicQuestionScreen> createState() => _DynamicQuestionScreenState();
}

class _DynamicQuestionScreenState extends State<DynamicQuestionScreen> {
  late List<Question> questions;
  int currentIndex = 0;
  Map<int, int> selectedOption = {}; // questionId → optionId
  final List<AnswerItem> answerList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SignupCubit>().getQuestionAbout();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Abut You",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              AppNavigator.go(AppRouterConstant.advancedDrawer);
            },
            icon: const Icon(Icons.check),
            label: const Text("Skip"),
          ),
        ],
      ),
      body: BlocConsumer<SignupCubit, SignupState>(
        buildWhen: (previous, current) => true,
        listener: (context, state) {
          if (state is AnswerFailure) {
            AppSnackBar.showError(context, state.message);
          } else if (state is AnswerSuccess) {
            AppSnackBar.showSuccess(context, "Answers submitted successfully!");
            AppNavigator.go(AppRouterConstant.advancedDrawer);
          }
        },
        builder: (context, state) {
          /// Loading
          if (state is SignupLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          /// When submitting answers → show loader
          if (state is AnswerLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          /// Success
          if (state is AboutQuestionSuccess) {
            final questions = state.aboutQuestion;
            if (questions.isEmpty) {
              return NoDataWidget(
                title: 'No Onboarding Questionnaire Found',
                description: 'Pull to refresh or try again.',
                onRefresh: () => context.read<SignupCubit>().getQuestionAbout(),
              );
            }

            return Stack(
              children: [
                questionWidget(state ,questions),
                if (state is AnswerLoading)
                  Container(
                    color: Colors.black.withOpacity(0.3),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
              ],
            );
          }

          /// Failure
          if (state is AboutQuestionFailure) {
            debugPrint('Error: ${state.errorMessage}');
            return NoDataWidget(
              title: 'Something went wrong',
              description: state.errorMessage,
              onRefresh: () => context.read<SignupCubit>().getQuestionAbout(),
            );
          }

          /// Initial / Fallback
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget questionWidget(SignupState state, List<Question> questions) {
    final currentQuestion = questions[currentIndex];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Provide your vendors",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Question ${currentIndex + 1} of ${questions.length}",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // ======================== HEADER ==========================
              Card(
                elevation: 10,
                clipBehavior: Clip.antiAlias,
                borderOnForeground: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  // 👈 rounded corners
                  side: const BorderSide(color: Colors.transparent, width: 2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    spacing: 8,
                    children: [
                      const SizedBox(height: 10),
                      // ========================= OPTIONS ========================
                      Text(
                        currentQuestion.text!,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...currentQuestion.options!.map(
                        (o) => GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedOption[currentQuestion.id!] = o.id!;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color:
                                    selectedOption[currentQuestion.id] == o.id
                                    ? Colors.red
                                    : Colors.grey,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  o.text!,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color:
                                        selectedOption[currentQuestion.id] ==
                                            o.id
                                        ? Colors.red
                                        : null,
                                    fontWeight:
                                        selectedOption[currentQuestion.id] ==
                                            o.id
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                                if (selectedOption[currentQuestion.id] == o.id)
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.red,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),

              Spacer(),
              // ========================= BUTTONS ========================
              Row(
                children: [
                  /// PREVIOUS BUTTON
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: currentIndex == 0
                            ? Colors.grey
                            : Colors.black87,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: currentIndex == 0
                          ? null
                          : () {
                              setState(() {
                                currentIndex--;
                              });
                              /// Just for debug (already selected will auto show)
                              final prevQuestion = questions[currentIndex];
                              debugPrint(
                                "⬅️ Previous Question: ${prevQuestion.id}, Selected Option: ${selectedOption[prevQuestion.id]}",
                              );
                            },
                      child: const Text("Previous"),
                    ),
                  ),

                  const SizedBox(width: 12),

                  /// NEXT / FINISH BUTTON OR LOADER
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            selectedOption[currentQuestion.id] == null
                            ? Colors.grey
                            : Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),

                      /// Disable button during loading
                      onPressed: (selectedOption[currentQuestion.id] == null || state is AnswerLoading)
                          ? null
                          : () {
                              final qId = currentQuestion.id!;
                              final optId = selectedOption[currentQuestion.id]!;

                              addOrUpdateAnswer(qId, optId);

                              if (currentIndex < questions.length - 1) {
                                setState(() {
                                  currentIndex++;
                                });
                              } else {
                                context.read<SignupCubit>().submitAnswers(
                                  answers: answerList,
                                );
                              }
                            },

                      /// Show loader instead of Finish/Next text
                      child: (state is AnswerLoading)
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(currentIndex == questions.length - 1 ? "Finish" : "Next"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addOrUpdateAnswer(int questionId, int optionId) {
    final index = answerList.indexWhere((e) => e.questionId == questionId);
    if (index != -1) {
      /// update existing
      answerList[index] = AnswerItem(
        questionId: questionId,
        optionId: optionId,
      );
    } else {
      /// add new
      answerList.add(AnswerItem(questionId: questionId, optionId: optionId));
    }
    debugPrint("✅ answerList = ${answerList.map((e) => e.toJson()).toList()}");
  }
}
