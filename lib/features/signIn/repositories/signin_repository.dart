import 'package:dio/dio.dart';
import 'package:nulook_app/core/network/api_end_points.dart';
import 'package:nulook_app/core/network/api_response.dart';
import 'package:nulook_app/features/signIn/model/user_model.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/api_services.dart';
import '../model/otp_model.dart';

class SignInRepository {

  final ApiServices _apiServices;

  SignInRepository(this._apiServices);

  /// 🔹 Login user
  Future<ApiResponse<UserModel>> signInRepository({required String phone}) async {
    try {
      final response = await _apiServices.post(
        ApiEndPoints.postRequestOTP(),
        body: {'phone_number': phone},
      );
      if (response.isSuccess && response.data != null) {
        final user = UserModel.fromJson(response.data);
        return ApiResponse.success(user, statusCode: response.statusCode);
      } else {
        return ApiResponse.failure(
          ApiError(message: response.error?.message ?? 'Login failed'),
          statusCode: response.statusCode,
        );
      }
    } on ApiException catch (e) {
      // Convert ApiException to ApiResponse
      return ApiResponse.failure(
        ApiError(message: e.errorMessage),
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

  Future<ApiResponse<OtpModel>> verifyOtpRepository({required String phone, required String otp}) async {
    try {
      final response = await _apiServices.post(ApiEndPoints.postVerifyOTP(),
          body: {'phone_number': phone, 'otp': otp}
      );
      if (response.isSuccess && response.data != null) {
        final user = OtpModel.fromJson(response.data);
        return ApiResponse.success(user, statusCode: response.statusCode);
      } else {
        return ApiResponse.failure(
          ApiError(message: response.error?.message ?? 'OTP failed'),
          statusCode: response.statusCode,
        );
      }
    } on ApiException catch (e) {
      // Convert ApiException to ApiResponse
      return ApiResponse.failure(
        ApiError(message: e.errorMessage),
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