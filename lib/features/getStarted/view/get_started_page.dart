import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nulook_app/core/constant/constant_assets.dart';
import 'package:nulook_app/core/constant/constant_data.dart';
import '../../../common/common_button.dart';
import '../../signIn/view/signin_page.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({super.key});

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(ConstantAssets.imagesFour, fit: BoxFit.cover),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black, Colors.black],
                stops: [0.0, 0.9, 0.9],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                tileMode: TileMode.repeated,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                ConstantAssets.nuLogo,
                width: 70,
                height: 70,
              ),
              const Text(
                ConstantData.welComeToNuLook,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                ConstantData.getStartedDesc,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: ConstantData.iAgreeTo,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                          text: ConstantData.termAndCond,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.red,
                            decorationStyle: TextDecorationStyle.solid,
                            color: Colors.red,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () =>
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => SignInPage()))
                      ),
                      const TextSpan(text: ' and '),
                      TextSpan(
                          text: ConstantData.privacyPolicy,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.red,
                            decorationStyle: TextDecorationStyle.solid,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () =>
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => SignInPage()))
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              CommonButton(
                title:  ConstantData.getStarted,
                isLoading: _isLoading,
                onPressed: _onContinuePressed,
              ),
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.center,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: ConstantData.alreadyHaveAnAcc,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const TextSpan(text: ' '),
                      TextSpan(
                          text: ConstantData.signIn,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.red,
                            decorationStyle: TextDecorationStyle.solid,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () =>
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => SignInPage()))
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ],
      ),
    );
  }
  void _onContinuePressed() async {
    setState(() => _isLoading = true);
    // Simulate API call or delay
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInPage(),
        ),
      );
    }
  }

}
