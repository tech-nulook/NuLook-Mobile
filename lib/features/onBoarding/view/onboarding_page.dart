import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:nulook_app/Features/onBoarding/view/onboard_page_three.dart';
import 'package:nulook_app/core/storage/secure_storage_constant.dart';
import 'package:nulook_app/features/onBoarding/view/onboard_page_four.dart';
import '../../../core/storage/secure_storage_helper.dart';
import '../../../core/storage/shared_preferences_helper.dart';
import '../../OnBoarding/view/onboard_page_one.dart';
import '../../getStarted/view/get_started_page.dart';
import 'onboard_page_two.dart';


class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(BuildContext context) async{
    await SharedPreferencesHelper.instance.setBool(SecureConstant.onboardingCompleted, true);
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const GetStartedPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final pageDecoration = const PageDecoration(
      imagePadding: EdgeInsets.zero,
      bodyPadding: EdgeInsets.zero,
      contentMargin: EdgeInsets.zero,
      footerPadding: EdgeInsets.zero,
      pageMargin: EdgeInsets.zero,
    );
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: IntroductionScreen(
          key: introKey,
          scrollPhysics: const NeverScrollableScrollPhysics(), // Prevents bounce/overscroll
          pages: [
            PageViewModel(
              titleWidget: SizedBox.shrink(),
              bodyWidget: SizedBox(
                width: double.infinity,
                height: size.height,
                child: OnboardPageOne(),
              ),
              decoration: pageDecoration,
            ),
            PageViewModel(
              titleWidget: SizedBox.shrink(),
              bodyWidget: SizedBox(
                width: double.infinity,
                height: size.height,
                child: OnboardPageTwo(),
              ),
              decoration: pageDecoration,
            ),
            PageViewModel(
              titleWidget: SizedBox.shrink(),
              bodyWidget: SizedBox(
                width: double.infinity,
                height: size.height,
                child: OnboardPageThree(),
              ),
              decoration: pageDecoration,
            ),
            PageViewModel(
              titleWidget: SizedBox.shrink(),
              bodyWidget: SizedBox(
                width: double.infinity,
                height: size.height,
                child: OnboardPageFour(),
              ),
              decoration: pageDecoration,
            ),
          ],
          onDone: () => _onIntroEnd(context),
          onSkip: () => _onIntroEnd(context),
          // You can override onSkip callback
          showSkipButton: false,
          skipOrBackFlex: 1,
          nextFlex: 1,
          showBackButton: true,
          //rtl: true, // Display as right-to-left
          back: const Icon(Icons.arrow_back, size: 25, color: Colors.white),
          skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
          next: const Icon(Icons.arrow_forward, size: 25, color: Colors.white),
          done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white)),
          curve: Curves.linear,
          controlsMargin: const EdgeInsets.all(0),
          controlsPadding: kIsWeb ? const EdgeInsets.all(10.0) : const EdgeInsets.all(20.0),
          dotsDecorator: const DotsDecorator(
            size: Size(10.0, 10.0),
            color: Colors.white,
            activeSize: Size(22.0, 10.0),
            activeColor: Colors.grey,
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
          //dotsFlex: 1,
          showDoneButton: true,
          doneStyle: ButtonStyle(
            padding: WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            ),
          ),
          dotsContainerDecorator: const ShapeDecoration(
            color: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
            ),
          ),
        ),
      ),
    );
  }

  PageDecoration getPageDecoration() => PageDecoration(
    titleTextStyle: TextStyle(fontSize: 0, fontWeight: FontWeight.bold),
    bodyTextStyle: TextStyle(fontSize: 0),
    boxDecoration: BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.all(Radius.circular(0)),
    ),
  );
}
