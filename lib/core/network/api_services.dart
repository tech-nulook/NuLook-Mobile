import 'dart:io';
import 'package:dio/dio.dart';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:nulook_app/core/network/api_end_points.dart';
import 'api_response.dart';
import 'appInterceptor.dart';

class ApiServices {
  static final ApiServices _instance = ApiServices._internal();
  factory ApiServices() => _instance;

  late Dio _dio;

  ApiServices._internal() {
    final baseOptions = BaseOptions(
      baseUrl: ApiEndPoints.baseUrl, // ✅ your base URL
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      //validateStatus: (_) => true,
      validateStatus: (status) => status != null && status >= 200 && status < 300,
    );
    _dio = Dio(baseOptions);
    _dio.interceptors.add(AppInterceptor(_dio));
  }

  Dio get dio => _dio;


  // 🔹 Common POST
  Future<ApiResponse<dynamic>> post(String path,
      {Map<String, dynamic>? body, Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      //final FormData formData = FormData.fromMap(body, ListFormat.multiCompatible);
      _dio.interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: true, convertFormData: true));
      final response = await _dio.post(path,
          data: body,
          queryParameters: queryParameters,
          options: options,
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

    // 🔹 GET
    Future<ApiResponse<dynamic>> get(String path, {Map<String, dynamic>? queryParameters}) async {
      try {
        final response = await _dio.get(path, queryParameters: queryParameters);
        return _handleResponse(response);
      } on DioException catch (e) {
        throw _handleError(e);
      }
    }

  // 🔹 PUT
  Future<ApiResponse<dynamic>> put(String path, {dynamic data}) async {
    try {
      final response = await _dio.put(path, data: data);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // 🔹 DELETE
  Future<ApiResponse<dynamic>> delete(String path) async {
    try {
      final response = await _dio.delete(path);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // 🔹 FILE UPLOAD
  Future<ApiResponse<dynamic>> uploadFile(String path, File file, {Map<String, dynamic>? fields, String fileKey = 'files' }) async {
    try {
      final fileName = file.path.split('/').last;
      final formData = FormData.fromMap({
        fileKey: await MultipartFile.fromFile(file.path, filename: fileName),
        if (fields != null) ...fields,
      });

      final response = await _dio.post(path, data: formData);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Upload multiple images
  Future<Response> uploadMultipleImages(List<File> files) async {
    try {
      List<MultipartFile> fileList = [];
      for (var file in files) {
        fileList.add(
          await MultipartFile.fromFile(
            file.path,
            filename: file.path.split('/').last,
          ),
        );
      }
      FormData formData = FormData.fromMap({
        "files": fileList,
      });
      final response = await _dio.post(
        "/file-upload/upload/images/?folder=mobile",
        data: formData,
      );

      return response;
    } catch (e) {
      throw Exception("Upload failed: $e");
    }
  }

  // 🔹 DOWNLOAD IMAGE / FILE
  Future<ApiResponse<dynamic>> downloadFile(String url, String savePath,  CancelToken cancelToken ,{ Function(int received, int total)? onProgress }) async {
    try {
      final response = await _dio.download(
        url,
        savePath,
        cancelToken: cancelToken,
        onReceiveProgress: onProgress,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: true,
          validateStatus: (status) => status! < 500,
        ),
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // 🔹 Response Handler
  ApiResponse<dynamic> _handleResponse(Response response) {
    final statusCode = response.statusCode ?? 0;
    final responseData = response.data;

    switch (statusCode) {
      case 200:
      case 201:
      case 202:
      case 204:
        return ApiResponse.success(responseData, statusCode: statusCode);
      case 400:
        return ApiResponse.failure(
          ApiError(message: responseData?['message'] ?? 'Bad Request (400)', details: responseData?['detail']),
          statusCode: statusCode,
        );
      case 401:
        return ApiResponse.failure(
          ApiError(message: responseData?['message'] ?? 'Unauthorized (401)', details: responseData,
          ),
          statusCode: statusCode,
        );
      case 403:
        return ApiResponse.failure(
          ApiError(message: responseData?['message'] ?? 'Forbidden (403)', details: responseData),
          statusCode: statusCode,
        );
      case 404:
        return ApiResponse.failure(
          ApiError(message: responseData?['message'] ?? 'Not Found (404)', details: responseData),
          statusCode: statusCode,
        );
      case 408:
        return ApiResponse.failure(
          ApiError(message: responseData?['message'] ?? 'Request Timeout (408)', details: responseData),
          statusCode: statusCode,
        );
      case 409:
        return ApiResponse.failure(
          ApiError(message: responseData?['message'] ?? 'Conflict (409)', details: responseData),
          statusCode: statusCode,
        );
      case 422:
        return ApiResponse.failure(
          ApiError(message: responseData?['message'] ?? 'Unprocessable Entity (422)', details: responseData),
          statusCode: statusCode,
        );
      case 500:
        return ApiResponse.failure(
          ApiError(message: responseData?['message'] ?? 'Internal Server Error (500)', details: responseData),
          statusCode: statusCode,
        );
      case 502:
        return ApiResponse.failure(
          ApiError(message: responseData?['message'] ?? 'Bad Gateway (502)', details: responseData,),
          statusCode: statusCode,
        );
      case 503:
        return ApiResponse.failure(
          ApiError(message: responseData?['message'] ?? 'Service Unavailable (503)', details: responseData),
          statusCode: statusCode,
        );
      case 504:
        return ApiResponse.failure(
          ApiError(message: responseData?['message'] ?? 'Gateway Timeout (504)', details: responseData),
          statusCode: statusCode,
        );
      default:
        return ApiResponse.failure(
          ApiError(message: 'Unexpected Status Code: $statusCode — ${responseData?['message'] ?? 'Unknown error'}',
            details: responseData,
          ),
          statusCode: statusCode,
        );
    }
  }

  // 🔹 Error Handler
  Exception _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return Exception("Connection Timeout");
      case DioExceptionType.sendTimeout:
        return Exception("Send Timeout");
      case DioExceptionType.receiveTimeout:
        return Exception("Receive Timeout");
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode ?? 0;
        final message = e.response?.data?['message'] ?? "Unknown Error";
        return Exception("Error [$statusCode]: $message");
      case DioExceptionType.cancel:
        return Exception("Request Cancelled");
      case DioExceptionType.connectionError:
        return Exception("Connection Error: ${e.message}");
      default:
        return Exception("Unexpected Error: ${e.message}");
    }
  }

}