
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nulook_app/core/constant/constant_data.dart';
import 'package:nulook_app/features/signIn/view/success_screen.dart';
import '../../../Features/about/view/about_main_screen.dart';
import '../../../common/app_snackbar.dart';
import '../../../common/common_button.dart';
import '../bloc/sign_in_cubit.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpScreen({super.key, required this.phoneNumber});

  static Widget getRouteInstance(String phoneNumber) => MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => SignInCubit()),
    ],
    child: OtpScreen(
      phoneNumber: phoneNumber,
    ),
  );

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  final int otpLength = 6;
  final _formKey = GlobalKey<FormState>();
  late List<TextEditingController> otpControllers ; //= List.generate(6, (index) => TextEditingController());
  late List<FocusNode> focusNodes;
  int secondsRemaining = 60;
  bool enableResend = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    otpControllers = List.generate(otpLength, (index) => TextEditingController());
    focusNodes = List.generate(otpLength, (_) => FocusNode());
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
        setState(() => secondsRemaining--);
      } else {
        setState(() => enableResend = true);
        timer.cancel();
      }
    });
  }

  void resendCode() {
    setState(() {
      secondsRemaining = 60;
      enableResend = false;
    });
    otpControllers.forEach((controller) => controller.clear());
    startTimer();
    // TODO: Add your resend OTP API call here
    context.read<SignInCubit>().signInUser(widget.phoneNumber);
    AppSnackBar.showInfo(context, ConstantData.otpResentSucess);
  }

  void onContinue() {
    String otp = otpControllers.map((e) => e.text).join();
    if (otp.length != 6 || otp.contains(RegExp(r'[^0-9]'))) {
      AppSnackBar.showError(context, ConstantData.enterValidDigitOtp);
      return;
    }
    // TODO: Verify OTP API call
    AppSnackBar.showSuccess(context, 'OTP Verified: $otp');
    Navigator.push(context,
      MaterialPageRoute(
        builder: (context) => const AboutMainScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            child: const Icon(Icons.arrow_back, color: Colors.white)))
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            crossAxisAlignment: .center,
            children: [
              const SizedBox(height: 40),
              const Text(
                "Secure Your Vibe 🔐",
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 16),
              Text(
                " ${ConstantData.enterSecurityCode} ${widget.phoneNumber}",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: .spaceEvenly,
                children: List.generate(otpLength, (index) =>
                    buildOtpBox(otpControllers[index],
                    autoFocus: index == 0,
                    index: index
                  ),
                ),
              ),
              const SizedBox(height: 20),
              enableResend ? GestureDetector(
                onTap: resendCode,
                child: const Text(
                  "Resend OTP",
                  style: TextStyle(color: Colors.redAccent, fontSize: 16),
                ),
              )
                  : Text(
                "Resend in ${secondsRemaining}s",
                style: const TextStyle(color: Colors.redAccent, fontSize: 16),
              ),
              const Spacer(),
              onContinuePressed(),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOtpBox(TextEditingController controller,  {bool autoFocus = false, required int index}) {
    return SizedBox(
      width: 50,
      child: TextField(
        controller: controller,
        focusNode: focusNodes[index],
        textAlign: .center,
        keyboardType: .number,
        maxLength: 1,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: .bold,
        ),
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: Colors.grey.shade900,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.redAccent),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1) {
            // Move focus to the next field if a character is entered
            if (index < focusNodes.length - 1) {
              FocusScope.of(context).requestFocus(focusNodes[index + 1]);
            }
          } else if (value.isEmpty) {
            // Move focus to the previous field and clear its content on backspace
            if (index > 0) {
              FocusScope.of(context).requestFocus(focusNodes[index - 1]);
              otpControllers[index].clear(); // Clear the previous field
            }
          }
        },
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
              debugPrint("✅ Valid phone: ${widget.phoneNumber}");
              debugPrint("✅ OTP : ${otpControllers.map((e) => e.text).join()}");
              var otp = otpControllers.map((e) => e.text).join();
              if(otp.length != otpLength || otp.contains(RegExp(r'[^0-9]'))){
                AppSnackBar.showInfo(context, ConstantData.enterValidDigitOtp);
                return;
              }
              context.read<SignInCubit>().verifyOtp(widget.phoneNumber, otp);
            } else {
              debugPrint("❌ Invalid phone: ${widget.phoneNumber}");
            }
          },
        );
      },
      listener: (context, state) async {
        if (state is OtpSuccess) {
          AppSnackBar.showSuccess(context, 'Otp Verified Successfully');
          await Future.delayed(Duration(seconds: 1));
          if (mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>  SuccessScreen.getRouteInstance(state.otpModel.status!),
              ),
            );
          }
        } else if(state is OtpFailure){
          AppSnackBar.showError(context, state.message);
        }
      },
    );
  }

  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (final f in focusNodes) {
      f.dispose();
    }
    timer?.cancel();
    super.dispose();
  }
}