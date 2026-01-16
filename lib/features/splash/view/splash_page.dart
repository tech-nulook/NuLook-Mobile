import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nulook_app/Features/signIn/view/signin_page.dart';
import 'package:nulook_app/core/routers/app_router_constant.dart';
import '../../../Features/OnBoarding/view/onboarding_page.dart';
import '../../../Features/about/bloc/signup_cubit.dart';
import '../../../Features/about/view/about_main_screen.dart';
import '../../../core/storage/shared_preferences_helper.dart';
import '../../home/view/advanced_drawer.dart';
import '../../../core/constant/constant_assets.dart';
import '../../../core/storage/secure_storage_constant.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late String? userId = '';
  late bool? isSignUp = false;

  @override
  void initState() {
    super.initState();
    // Fade-in animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();

    //Navigate after 2 seconds
    // Timer(const Duration(seconds: 2), () {
    //   if(mounted){
    //     Navigator.of(context).pushReplacement(
    //       MaterialPageRoute(
    //         builder: (context) => const OnBoardingPage(),
    //       ),
    //     );
    //   }
    // });
  }

  Future<bool> getOnboardingCompleted() async {
    debugPrint('🔍 Fetching onboarding status from secure storage...');
    await Future.delayed(const Duration(seconds: 3));
    userId = SharedPreferencesHelper.instance.getString(SecureConstant.userId);
    isSignUp =  SharedPreferencesHelper.instance.getBool(SecureConstant.signUp);
    debugPrint('✅ Fetching secure storage...userId $userId # isSignUp : $isSignUp');
    bool? storedValue = SharedPreferencesHelper.instance.getBool(SecureConstant.onboardingCompleted);
    debugPrint('📥 Raw stored onboarding value: $storedValue');
    // Convert to bool safely
    bool result = storedValue ?? false;
    debugPrint('🔍 Final onboarding bool: $result');

    return result;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: getOnboardingCompleted(),
        builder: (context, snapshot) {
          if (ConnectionState.waiting == snapshot.connectionState) {
            return bodyWidgetStack(context);
          } else if (ConnectionState.done == snapshot.connectionState) {
            final onboardingCompleted = snapshot.data;
            debugPrint("✅ Onboarding Completed: $onboardingCompleted");
            if (onboardingCompleted! == false) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                // Navigator.of(context).pushReplacement(
                //   MaterialPageRoute(
                //     builder: (context) => const OnBoardingPage(),
                //   ),
                // );
                context.goNamed(AppRouterConstant.onBoardingPage);
              });
            } else if (userId == null || userId == '') {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.goNamed(AppRouterConstant.signInPage);
                // Navigator.of(context).pushReplacement(
                //   MaterialPageRoute(builder: (context) => const SignInPage()), //SignInPage
                // );
              });
            } else if (isSignUp == false || isSignUp == null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.goNamed(AppRouterConstant.aboutMainScreen);
                // Navigator.of(context).pushReplacement(
                //   MaterialPageRoute(builder: (context) => const AboutMainScreen()),
                // );
              });
            } else {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.goNamed(AppRouterConstant.advancedDrawer);
                // Navigator.of(context).pushReplacement(
                //   MaterialPageRoute(
                //     builder: (context) =>  AdvancedDrawerWidget.getRouteInstance(),  //AdvancedDrawerWidget
                //   ),
                // );
              });
            }
          }
          return bodyWidgetStack(context);
        },
      ),
    );
  }

  Stack bodyWidgetStack(BuildContext context) {
    return Stack(
      children: [
        /// -------- BACKGROUND IMAGE --------
        Positioned.fill(
          child: Image.asset(
            ConstantAssets.imagesThree, // your background
            fit: BoxFit.cover,
          ),
        ),

        /// -------- TRANSPARENT BLACK OVERLAY --------
        Container(
          color: Colors.black.withOpacity(0.77), // adjust opacity
        ),

        /// -------- CONTENT --------
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              /// -------- LOGO --------
              FadeTransition(
                opacity: _animation,
                child: Image.asset(
                  ConstantAssets.nuLogo,
                  width: 200,
                  height: 100,
                ),
              ),

              /// -------- MAIN TEXT --------
              const Text(
                "Confidence, On Demand.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              /// -------- SUB TEXT --------
              const Text(
                "For every look — powered by NuLook.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 15),
              ),

              const Spacer(),

              /// -------- NEXT BUTTON AREA --------
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 30),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/next");
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE64752), // red button
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_right_alt_rounded,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
