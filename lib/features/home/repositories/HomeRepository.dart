
import '../../../core/network/api_end_points.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/api_response.dart';
import '../../../core/network/api_services.dart';
import '../model/feeltoday.dart';

class HomeRepository {
  Future<ApiResponse<List<FeelToday>>> getTodayFeeling(String type) async {
    try {
      final response =
      await ApiServices().get(ApiEndPoints.getTags(type: type));

      if (response.isSuccess && response.data != null) {
        final data = response.data;

        if (data is List) {
          final feelings = data
              .map((e) => FeelToday.fromJson(e as Map<String, dynamic>))
              .toList();

          return ApiResponse.success(
            feelings,
            statusCode: response.statusCode,
          );
        }

        // If API returns object but we expect list
        return ApiResponse.failure(
          ApiError(message: "Invalid response format. Expected List"),
          statusCode: response.statusCode,
        );
      }

      return ApiResponse.failure(
        ApiError(
          message: response.error?.message ?? 'Failed to load feelings',
          details: response.error?.details,
        ),
        statusCode: response.statusCode,
      );
    } on ApiException catch (e) {
      return ApiResponse.failure(
        ApiError(message: e.errorMessage, details: "$e"),
        statusCode: e.errorCode,
      );
    } catch (e) {
      return ApiResponse.failure(
        ApiError(message: 'Unexpected error occurred: $e'),
        statusCode: 0,
      );
    }
  }
}