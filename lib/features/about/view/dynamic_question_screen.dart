import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/widgets/no_data_widget.dart';
import '../../home/view/advanced_drawer.dart';
import '../bloc/signup_cubit.dart';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SignupCubit>().getQuestionAbout();
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return BlocBuilder<SignupCubit, SignupState>(
  //     builder: (context, state) {
  //       if (state is SignupLoading) {
  //         return const Center(child: CircularProgressIndicator());
  //       } else if (state is AboutQuestionSuccess) {
  //         questions = state.aboutQuestion.cast<AboutQuestion>();
  //         return questionWidget(questions);
  //       } else if (state is AboutQuestionFailure) {
  //         debugPrint("Error: ${state.errorMessage}");
  //         return Container();
  //       }
  //       return const Center(child: Text("No data found"));
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Abut You",  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const AdvancedDrawerWidget();
                  },
                ),
              );
            },
            icon: const Icon(Icons.check),
            label: const Text(
              "Skip",
            ),
          ),
        ],
      ),
      body: BlocBuilder<SignupCubit, SignupState>(
        builder: (context, state) {
          /// Loading
          if (state is SignupLoading) {
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
            return questionWidget(questions);
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

  Widget questionWidget(List<Question> questions) {
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
                      // LinearProgressIndicator(
                      //   value: (currentIndex + 1) / aboutQuestion.length,
                      //   backgroundColor: Colors.grey.shade300,
                      //   color: Colors.blue,
                      //   minHeight: 8,
                      // ),
                      const SizedBox(height: 10),
                      // Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: Text(
                      //     "Question ${currentIndex + 1} of ${aboutQuestion.length}",
                      //     style: const TextStyle(
                      //       fontSize: 16,
                      //       fontWeight: FontWeight.w600,
                      //     ),
                      //   ),
                      // ),
                      // ========================= OPTIONS ========================
                      Text(
                        currentQuestion.text!,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...currentQuestion.options!.map((o) => GestureDetector(
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
              // ========================= NEXT BUTTON ====================
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedOption[currentQuestion.id] == null
                      ? Colors.grey
                      : Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: selectedOption[currentQuestion.id] == null
                    ? null
                    : () {
                        if (currentIndex < questions.length - 1) {
                          setState(() {
                            currentIndex++;
                          });
                        } else {
                          debugPrint("🎉 Completed");
                          debugPrint("Selected: $selectedOption");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdvancedDrawerWidget.getRouteInstance(),
                            ),
                          );
                        }
                      },
                child: Text(
                  currentIndex == questions.length - 1 ? "Finish" : "Next",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
