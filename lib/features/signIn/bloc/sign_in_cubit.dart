import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:nulook_app/core/network/api_services.dart';
import 'package:nulook_app/core/storage/secure_storage_constant.dart';

import '../../../core/storage/secure_storage_helper.dart';
import '../../../core/storage/shared_preferences_helper.dart';
import '../model/otp_model.dart';
import '../model/user_model.dart';
import '../repositories/signin_repository.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {

  final SignInRepository signInRepository = SignInRepository(ApiServices());

  SignInCubit() : super(SignInInitial());

  Future<void> signInUser(String phone) async {
    emit(LoadingState());
    try {
      final result = await signInRepository.signInRepository(phone: phone);
      if (result.isSuccess && result.data != null) {
        final user = result.data!;
        emit(SignInSuccess(user.message));
        debugPrint('✅ Logged in: ${user.message}, Refresh: ${user.message}');
      } else {
        final msg = result.error?.message ?? 'Login failed';
        emit(SignInFailure(msg));
        debugPrint('❌ Error: $msg (code: ${result.statusCode})');
      }
    } catch (e, stack) {
      emit(SignInFailure('Unexpected error: $e'));
      debugPrint('❌ Exception during sign-in: $e\n$stack');
    }
  }

  Future<void> verifyOtp(String phone,String otp) async {
    emit(LoadingState());
    try {
      final result = await signInRepository.verifyOtpRepository(phone: phone,otp: otp);
      if (result.isSuccess && result.data != null) {
        final otpModel = result.data!;
        // Store access token securely
        await SharedPreferencesHelper.instance.setString(SecureConstant.accessTokenKey, otpModel.accessToken!);
        await SharedPreferencesHelper.instance.setString(SecureConstant.userId, otpModel.customer!.id!.toString());
        await SharedPreferencesHelper.instance.setString(SecureConstant.phoneNumber, otpModel.customer!.phoneNumber!);
        emit(OtpSuccess(otpModel));
        debugPrint('✅ OTP in: ${otpModel.customer!.id}, phoneNumber: ${otpModel.customer!.phoneNumber}');
      } else {
        final msg = result.error?.message ?? result.error!.details;
        emit(OtpFailure(msg));
        debugPrint('❌ Error: $msg (code: ${result.statusCode})');
      }
    } catch (e, stack) {
      emit(OtpFailure('Unexpected error: $e'));
      debugPrint('❌ Exception during sign-in: $e\n$stack');
    }
  }
}
