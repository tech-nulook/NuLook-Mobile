
import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../../../core/network/api_end_points.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/api_response.dart';
import '../../../core/network/api_services.dart';
import '../model/customer_details.dart';
import '../model/question.dart';
import '../model/signup.dart';

class SignupRepository {

  Future<ApiResponse<SignupModel>> signUpRepository({required Map<String, dynamic>? queryParametersRequest}) async {
    try {
      final response = await ApiServices().put(ApiEndPoints.postSignUp(),data: queryParametersRequest);
      if (response.isSuccess && response.data != null) {
        final user = SignupModel.fromJson(response.data);
        return ApiResponse.success(user, statusCode: response.statusCode);
      } else {
        return ApiResponse.failure(
          ApiError(message: response.error?.message ?? 'Update failed' ,details: response.error?.details),
          statusCode: response.statusCode,
        );
      }
    } on ApiException catch (e) {
      // Convert ApiException to ApiResponse
      return ApiResponse.failure(
        ApiError(message: e.errorMessage, details: "$e"),
        statusCode: e.errorCode,
      );
    } catch (e) {
      // Fallback for unknown errors
      return ApiResponse.failure(
        ApiError(message: 'Unexpected error occurred: $e'),
        statusCode: 0,
      );
    }
  }

  Future<ApiResponse<List<Question>>> questionRepository() async {
    try {
      final response = await ApiServices().get(ApiEndPoints.getQuestion());

      debugPrint('Question Repository Response: ${response.data}');

      if (response.isSuccess && response.data != null && response.data != []) {
        final rawList = response.data as List<dynamic>;

        List<Question> questions = rawList
            .map((e) => Question.fromJson(e as Map<String, dynamic>))
            .toList();

        return ApiResponse.success(questions, statusCode: response.statusCode);
      } else {
        return ApiResponse.failure(
          ApiError(
            message: response.error?.message ?? 'failed',
            details: response.error?.details,
          ),
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return ApiResponse.failure(
        ApiError(message: 'Unexpected error: $e'),
        statusCode: 0,
      );
    }
  }


  Future<ApiResponse<dynamic>> fileUploadRepository(List<File> files) async {
    try {
      final response = await ApiServices().uploadFile(ApiEndPoints.postFileUpload(), files[0]);
      if (response.isSuccess && response.data != null) {
        // response.data is a List → extract first URL
        final fileUrl = (response.data is List && response.data.isNotEmpty) ? response.data.first : null;
        return ApiResponse.success(fileUrl , statusCode: response.statusCode);
      } else {
        return ApiResponse.failure(
          ApiError(
            message: response.error?.message ?? 'failed',
            details: response.error?.details,
          ),
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return ApiResponse.failure(
        ApiError(message: 'Unexpected error: $e'),
        statusCode: 0,
      );
    }
  }

  Future<ApiResponse<CustomerDetails>> customerDetailsRepository() async {
    try {
      final response = await ApiServices().get(ApiEndPoints.getCustomerDetails());
      if (response.isSuccess && response.data != null) {
        final customerDetails = CustomerDetails.fromJson(response.data);
        return ApiResponse.success(customerDetails, statusCode: response.statusCode);
      } else {
        return ApiResponse.failure(
          ApiError(message: response.error?.message ?? ' failed' ,details: response.error?.details),
          statusCode: response.statusCode,
        );
      }
    } on ApiException catch (e) {
      return ApiResponse.failure(
        ApiError(message: e.errorMessage, details: "$e"),
        statusCode: e.errorCode,
      );
    } catch (e) {
      // Fallback for unknown errors
      return ApiResponse.failure(
        ApiError(message: 'Unexpected error occurred: $e'),
        statusCode: 0,
      );
    }
  }




}