import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nulook_app/core/routers/app_navigator.dart';
import 'package:nulook_app/core/routers/app_router_constant.dart';
import '../../../Features/about/bloc/signup_cubit.dart';
import '../../../core/constant/constant_assets.dart';
import '../../../core/storage/shared_preferences_helper.dart';
import '../../../core/storage/secure_storage_constant.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static Widget getRouteInstance() => MultiBlocProvider(
    providers: [BlocProvider(create: (context) => SignupCubit())],
    child: const SplashPage(),
  );

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  String? userId;
  String? userName;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleNavigation();
    });
  }

  Future<void> _handleNavigation() async {

    // splash delay
    await Future.delayed(const Duration(seconds: 3));

    // 1) onboarding check
    final onboardingCompleted = SharedPreferencesHelper.instance.getBool(SecureConstant.onboardingCompleted,) ?? false;

    if (!onboardingCompleted) {
      AppNavigator.goNamed(AppRouterConstant.onBoardingPage);
      return;
    }else{
      if (mounted) {
        await context.read<SignupCubit>().getCustomerDetails(context);
      }
    }
    // 2) userId check
    userId = SharedPreferencesHelper.instance.getString(SecureConstant.userId);

    if (userId == null || userId!.trim().isEmpty) {
      AppNavigator.goNamed(AppRouterConstant.signInPage);
      return;
    }
    // 4) after API response decide navigation
    String? userName =  SharedPreferencesHelper.instance.getString(SecureConstant.userName);
    await Future.delayed(const Duration(seconds: 1));
    final isUserNameValid = userName != null && userName.trim().isNotEmpty;
    debugPrint("✅ isUserNameValid: $isUserNameValid");
    if (!isUserNameValid) {
      AppNavigator.goNamed(AppRouterConstant.aboutMainScreen);
      return;
    }
    AppNavigator.goNamed(AppRouterConstant.advancedDrawer);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: bodyWidgetStack(context));
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
