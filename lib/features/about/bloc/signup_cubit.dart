import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/bloc/user_pref_cubit.dart';
import '../../../core/storage/secure_storage_constant.dart';
import '../../../core/storage/shared_preferences_helper.dart';
import '../model/customer_details.dart';
import '../model/question.dart';
import '../model/signup.dart';
import '../repositories/SignUpRepository.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupRepository _signupRepository = SignupRepository();

  SignupCubit() : super(SignupInitial());

  Future<void> signUpUser(Map<String, dynamic>? queryParametersRequest) async {
    emit(SignupLoading());
    try {
      debugPrint("queryParametersRequest = ${jsonEncode(queryParametersRequest)}");
      final result = await _signupRepository.signUpRepository(queryParametersRequest: queryParametersRequest);
      if (result.isSuccess && result.data != null) {
        final signup = result.data!;
        await SharedPreferencesHelper.instance.setBool(SecureConstant.signUp, true);
        await SharedPreferencesHelper.instance.saveObject(SecureConstant.userProfileData, signup.toJson());

        debugPrint('✅ Signed up: ${signup.name}, Email: ${signup.email}');
        emit(SignupSuccess(signup));
      } else {
        final msg = '${result.error!.message} ${"\n"} ${result.error?.details}';
        emit(SignupFailure(msg));
        debugPrint('❌ Error: $msg (code: ${result.statusCode} ) details: ${ result.error?.details }');
      }
    } catch (e, stack) {
      emit(SignupFailure('Unexpected error: $e'));
      debugPrint('❌ Exception during sign-up: $e\n$stack');
    }
  }

  Future<void> postFileUpload(List<File> files) async {
    emit(FileUploadingLoading());
    try {
      final result = await _signupRepository.fileUploadRepository(files);
      if (result.isSuccess && result.data != null) {
        final file = result.data!;
        emit(FileUploadSuccess(file));
      } else {
        final msg = '${result.error!.message} ${"\n"} ${result.error?.details}';
        emit(FileUploadFailure(msg));
        debugPrint('❌ Error during file upload: $msg (code: ${result.statusCode} ) details: ${ result.error?.details }');
      }
    } catch (e, stack) {
      emit(FileUploadFailure('Unexpected error during file upload: $e'));
      debugPrint('❌ Exception during file upload: $e\n$stack');
    }
  }

  Future<void> getUpdatedUserProfileDetails() async {
    emit(UserProfileLoading());
    try {
      final json = await SharedPreferencesHelper.instance.getObject(SecureConstant.userProfileData);
      if (json == null) {
        emit(UserProfileEmpty());
        return;
      }
      final user = SignupModel.fromJson(json);
      emit(UserProfileLoaded(user));
    } catch (e, stack) {
      debugPrint('❌ Error fetching user profile: $e');
      debugPrint('$stack');
      emit(UserProfileError(e.toString()));
    }
  }

  Future<void> getQuestionAbout() async {
    emit(SignupLoading());
    try {
      final result = await _signupRepository.questionRepository();

      if (result.isSuccess && result.data != null && result.data != []) {
        final List<Question> questions = result.data!; // ✅ use parsed list
        emit(AboutQuestionSuccess(questions));

        await SharedPreferencesHelper.instance.setBool(SecureConstant.signUp, true);
      } else {
        final msg = '${result.error?.message}\n${result.error?.details}';
        emit(AboutQuestionFailure(msg));
      }
    } catch (e, stack) {
      emit(AboutQuestionFailure('Unexpected error: $e'));
      debugPrint('❌ Exception: $e\n$stack');
    }
  }
  Future<void> getCustomerDetails(BuildContext context) async {
    emit(CustomerLoading());
    try {
      final result = await _signupRepository.customerDetailsRepository();

      if (result.isSuccess && result.data != null && result.data != []) {
        final CustomerDetails customerDetails  = result.data!;
        debugPrint(' Customer Details fetched: ${customerDetails.customer!.name}, Email: ${customerDetails.customer!.email}');
        await  context.read<UserPrefCubit>().saveUserData(
          userName: customerDetails.customer!.name,
          userEmail: customerDetails.customer!.email,
          phoneNumber: customerDetails.customer!.phoneNumber,
          userPicture: customerDetails.customer!.picture,
          gender: customerDetails.customer!.gender,
          location: customerDetails.customer!.location,
        );
        emit(CustomerLoaded(customerDetails));

      } else {
        final msg = '${result.error?.message}\n${result.error?.details}';
        emit(CustomerError(msg));
      }
    } catch (e, stack) {
      emit(CustomerError('Unexpected error: $e'));
      debugPrint('❌ Exception: $e\n$stack');
    }
  }

  //{status: success, customer: {id: 9, name: null, phone_number: 9861962002, email: null, gender: null, dob: null, location: null, picture: null, status: existing, user_id: 147, user_details: {id: 147, username: 9861962002, email: 9861962002, role: customer}}, message: Customer details retrieved successfully}
}
