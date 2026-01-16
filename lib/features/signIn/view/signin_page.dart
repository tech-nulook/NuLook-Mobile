import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nulook_app/common/utils/notification_utility.dart';
import 'package:nulook_app/common/utils/validators.dart';
import 'package:nulook_app/features/signIn/bloc/sign_in_cubit.dart';

import '../../../Features/about/view/about_main_screen.dart';
import '../../../common/app_snackbar.dart';
import '../../../common/common_button.dart';
import '../../../common/rounded_textfield.dart';
import '../../../core/constant/constant_data.dart';
import 'otp_screen.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Stack(
          children: [
            Positioned.fill(
              child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2,tileMode: TileMode.repeated),
                  child: Image.asset('assets/images/image_five.jpg', fit: BoxFit.cover)),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black, Colors.black],
                  stops: [0.0, 0.9, 0.9],
                  begin: .topCenter,
                  end: .bottomCenter,
                  tileMode: TileMode.repeated,
                ),
              ),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: true,
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: .end,
                  crossAxisAlignment: .stretch,
                  mainAxisSize: .max,
                  children: [
                    const SizedBox(height: 0),
                    Image.asset(
                      'assets/icons/nulook_logo.png',
                      width: 70,
                      height: 70,
                    ),
                    const Text(
                      "Step In , Glow Up",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Enter your mobile number  to start your NuLook journey",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RoundedTextField(
                        controller: _phoneController,
                        hintText: "Enter number",
                        prefixIcon: Icons.phone,
                        fillColor: Colors.grey.shade800,
                        focusedBorderColor: Colors.white,
                        textColor: Colors.white,
                        keyboardType: TextInputType.phone,
                        validator: Validators.validatePhone,
                      ),
                    ),
                    const SizedBox(height: 10),
                    onContinuePressed(),
                    const SizedBox(height: 10),
                    Container(
                      alignment: Alignment.center,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Already have an account ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const TextSpan(text: ' '),
                            TextSpan(
                                text: 'signIn',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () =>
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (_) => AboutMainScreen()))
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQueryData.fromView(window).viewInsets.bottom + 50),
                  ],
                ),
              ),
            ),
          ]
      ),
    );
  }

  Widget onContinuePressed()  {
   return BlocConsumer<SignInCubit, SignInState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Center(child: CircularProgressIndicator(color: Colors.white,)),
          );
        }
        return CommonButton(
          title: ConstantData.continues,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              debugPrint("✅ Valid phone: ${_phoneController.text}");
              // NotificationUtility.displayNotification(
              //     '✅ NuLook login Verification ✅',
              //     '✅ NuLook OTP sent to ${_phoneController.text} ✅',
              //     'https://graphicsfamily.com/wp-content/uploads/2020/11/Professional-Web-Banner-AD-in-Photoshop-scaled.jpg', {});
              context.read<SignInCubit>().signInUser(_phoneController.text);
            } else {
              debugPrint("❌ Invalid phone: ${_phoneController.text}");
            }
          },
        );
      },
      listener: (context, state) async {
        if (state is SignInSuccess) {
          AppSnackBar.showSuccess(context, state.messages);
          await Future.delayed(Duration(seconds: 1));
          if (mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>  OtpScreen.getRouteInstance(_phoneController.text),
              ),
            );

          }
        } else if(state is SignInFailure){
          AppSnackBar.showError(context, state.message);
        }
      },
    );
  }
}
