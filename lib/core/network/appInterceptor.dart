

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nulook_app/core/network/api_end_points.dart';

import '../../Features/signIn/view/signin_page.dart';
import '../../main.dart';
import '../storage/secure_storage_constant.dart';
import '../storage/secure_storage_helper.dart';
import '../storage/shared_preferences_helper.dart';

class AppInterceptor extends Interceptor {
  final Dio _dio;

  AppInterceptor(this._dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    debugPrint("➡️ [REQUEST] ${options.method} ${options.uri}");

    // 🧠 Skip token for public endpoints
    final isPublicEndpoint =
        options.path.contains(ApiEndPoints.postVerifyOTP()) ||
        options.path.contains(ApiEndPoints.postRequestOTP()) ||
        options.path.contains(ApiEndPoints.postFileUpload()) ||
        options.path.contains('/auth/refresh-token');

    if (!isPublicEndpoint) {
      final token =  _getAccessToken();
      if (token != null) {
        debugPrint("🔐 Attaching token : $token");
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    // ✅ Force JSON header for all requests unless explicitly overridden
    options.headers.putIfAbsent('accept', () => 'application/json');
    options.headers.putIfAbsent('Content-Type', () => 'application/json');
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async{
    debugPrint("✅ [RESPONSE] ${response.statusCode} => ${response.data}");

    if (response.statusCode == 401) {
      debugPrint("🚫 401 detected in onResponse");
      await _forceLogout();
      return handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        ),
      );
    }
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint("❌ [ERROR] ${err.response?.statusCode} => ${err.response?.data}");
    const retryKey = 'isRetry';
    if (err.response?.statusCode == 401) {
      final isRetry = err.requestOptions.extra[retryKey] == true;

      // ❌ Already retried once → logout
      if (isRetry) {
        await _forceLogout();
        return handler.reject(err);
      }
      final refreshed = await _refreshToken();
      if (refreshed) {
        err.requestOptions.extra[retryKey] = true;
        final response = await _retryRequest(err.requestOptions);
        return handler.resolve(response);
      } else {
        // 🚫 Refresh failed → logout
        await _forceLogout();
      }
    }
    return handler.next(err);
  }

  String? _getAccessToken(){
    final token =  SharedPreferencesHelper.instance.getString(SecureConstant.accessTokenKey);
    return token;
  }


  Future<Response> _retryRequest(RequestOptions requestOptions) async {
    final newOptions = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    final response = await _dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: newOptions,
    );

    return response;
  }

  Future<void> _forceLogout() async {
    await SharedPreferencesHelper.instance.clear();
    // IMPORTANT: Use global navigator key
    navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const SignInPage()), (route) => false,
    );
  }

  Future<bool> _refreshToken() async {
    try {
      final refreshToken = SharedPreferencesHelper.instance.getString("refreshTokenKey");
      if (refreshToken == null) return false;
      final response = await _dio.post(
        '/auth/refresh-token',
        data: {'refresh_token': refreshToken},
        options: Options(headers: {'Authorization': null}),
      );
      final newToken = response.data['access_token'];
      await SharedPreferencesHelper.instance.setString(SecureConstant.accessTokenKey, newToken);

      debugPrint("🔁 Token refreshed successfully");
      return true;
    } catch (e) {
      debugPrint("🚫 Token refresh failed: $e");
      return false;
    }
  }

}