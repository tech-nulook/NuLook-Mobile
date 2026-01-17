import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:nulook_app/common/common_button.dart';
import 'package:nulook_app/core/constant/constant_data.dart';
import 'package:nulook_app/core/routers/app_navigator.dart';

import '../../../Features/about/bloc/signup_cubit.dart';
import '../../../Features/about/view/about_main_screen.dart';
import '../../../Features/home/view/advanced_drawer.dart';
import '../../../core/routers/app_router_constant.dart';
import '../../about/view/dynamic_question_screen.dart';

class SuccessScreen extends StatefulWidget {
  final String status;
  const SuccessScreen({super.key, required this.status});

  static Widget getRouteInstance(String status) => MultiBlocProvider(
    providers: [BlocProvider(create: (context) => SignupCubit())],
    child: SuccessScreen(status: status),
  );


  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  void initState() {
    //Navigate after 2 seconds
    // Timer(const Duration(seconds: 5), () {
    //   if(mounted){
    //     Navigator.of(context).pushReplacement(
    //       MaterialPageRoute(
    //         builder: (context) => const AboutMainScreen(),
    //       ),
    //     );
    //   }
    // });
    context.read<SignupCubit>().getCustomerDetails(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            // Success Ico
            const SizedBox(height: 20),

            Container(
              color: Colors.black,
              child: Lottie.asset(
                'assets/lottie/success.json',
                width: 150,
                height: 150,
                repeat: true,
              ),
            ),

            // Title
            const Text(
              "Successful!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            // Illustration Image (add your own image in assets)
            // SizedBox(
            //   height: 230,
            //   child: Image.asset("assets/images/success_illustration.png"),
            // ),
            const SizedBox(height: 30),

            // Sub Text
            const Text(
              "Your vibe is verified.\nLet’s make this personal.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),

            const SizedBox(height: 50),

            // Continue Button
            CommonButton(
              title: ConstantData.continues,
              onPressed: () {
                debugPrint("Success Screen Status: ${widget.status}");
                if (widget.status == 'existing_customer') {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    AppNavigator.go(AppRouterConstant.advancedDrawer);
                  });
                } else if (widget.status == 'new_customer') {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    AppNavigator.go(AppRouterConstant.aboutMainScreen);
                  });
                } else {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    AppNavigator.go(AppRouterConstant.aboutMainScreen);
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
