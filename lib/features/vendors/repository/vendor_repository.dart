
import '../../../core/network/api_end_points.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/api_response.dart';
import '../../../core/network/api_services.dart';
import '../model/vendor.dart' show Vendor;
import '../model/vendor_packages.dart' show VendorPackages;

class VendorRepository {

  Future<ApiResponse<Vendor>> getSalonsRepository({Map<String, dynamic>? queryParams}) async {
    try {
      // Make API call
      final response = await ApiServices().get(ApiEndPoints.getVendorsAsListOfSalon());
      // Success and data available
      if (response.isSuccess && response.data != null) {
        final salons = Vendor.fromJson(response.data);
        return ApiResponse.success(
          salons,
          statusCode: response.statusCode,
        );
      }

      // Failure case
      return ApiResponse.failure(
        ApiError(
          message: response.error?.message ?? 'Failed to load vendors',
          details: response.error?.details,
        ),
        statusCode: response.statusCode,
      );
    } on ApiException catch (e) {
      // Convert ApiException to ApiResponse
      return ApiResponse.failure(
        ApiError(
          message: e.errorMessage,
          details: "$e",
        ),
        statusCode: e.errorCode,
      );
    } catch (e) {
      // Unknown/unexpected error
      return ApiResponse.failure(
        ApiError(message: 'Unexpected error occurred: $e'),
        statusCode: 0,
      );
    }
  }

  Future<ApiResponse<VendorPackages>> getVendorPackages({Map<String, dynamic>? queryParams}) async {
    try {
      // Make API call
      final response = await ApiServices().get(ApiEndPoints.getVendorPackages(),
        queryParameters: queryParams
      );
      // Success and data available
      if (response.isSuccess && response.data != null) {
        final salons = VendorPackages.fromJson(response.data);
        return ApiResponse.success(
          salons,
          statusCode: response.statusCode,
        );
      }

      // Failure case
      return ApiResponse.failure(
        ApiError(
          message: response.error?.message ?? 'Failed to load vendors',
          details: response.error?.details,
        ),
        statusCode: response.statusCode,
      );
    } on ApiException catch (e) {
      // Convert ApiException to ApiResponse
      return ApiResponse.failure(
        ApiError(
          message: e.errorMessage,
          details: "$e",
        ),
        statusCode: e.errorCode,
      );
    } catch (e) {
      // Unknown/unexpected error
      return ApiResponse.failure(
        ApiError(message: 'Unexpected error occurred: $e'),
        statusCode: 0,
      );
    }
  }





}