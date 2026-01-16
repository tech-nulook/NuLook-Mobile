

class ApiResponse<T> {
  final T? data;
  final ApiError? error;
  final int? statusCode;
  final bool isSuccess;

  ApiResponse.success(this.data, {this.statusCode})
      : error = null,
        isSuccess = true;

  ApiResponse.failure(this.error, {this.statusCode})
      : data = null,
        isSuccess = false;
}

class ApiError {
  final String message;
  final dynamic details;

  ApiError({required this.message, this.details});

  @override
  String toString() => 'ApiError(message: $message, details: $details)';
}