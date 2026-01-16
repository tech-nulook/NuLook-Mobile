import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nulook_app/features/vendors/model/vendor.dart';
import '../model/vendor_packages.dart' show VendorPackages, ServiceVariationItem;
import '../repository/vendor_repository.dart';

part 'vendors_state.dart';

class VendorsCubit extends Cubit<VendorsState> {
  final VendorRepository repository = VendorRepository();

  VendorsCubit() : super(VendorsInitial());

  Future<void> loadVendors({Map<String, dynamic>? queryParams}) async {
    try {
      emit(VendorsLoading());
      final response = await repository.getSalonsRepository();
      if (response.isSuccess && response.data != null) {
        emit(VendorsLoaded(vendor: response.data));
      } else {
        emit(
          VendorsError(
            message: response.error?.message ?? "Failed to load vendors",
            details: response.error?.details,
          ),
        );
      }
    } catch (e) {
      emit(
        VendorsPackagesError(message: "Failed to load vendors", details: "$e"),
      );
    }
  }

  Future<void> loadVendorPackages({Map<String, dynamic>? queryParams}) async {
    try {
      emit(VendorsLoading());
      final response = await repository.getVendorPackages(
        queryParams: queryParams,
      );
      if (response.isSuccess && response.data != null && response.data!.packages.isNotEmpty) {

        final items =  getServiceVariationItems(response.data!);
        emit(VendorsPackagesLoaded(vendorPackages: response.data, serviceVariationItem: items));

      } else {
        emit(
          VendorsPackagesError(
            message: response.error?.message ?? "Failed to load vendors",
            details: response.error?.details,
          ),
        );
      }
    } catch (e) {
      emit(
        VendorsPackagesError(
          message: "Failed to load vendors package",
          details: "$e",
        ),
      );
    }
  }

  List<ServiceVariationItem> getServiceVariationItems(VendorPackages vendorPackages) {

    return vendorPackages.packages
        .expand((package) => package.services)
        .where((service) => service.variations.isNotEmpty)
        .expand((service) => service.variations.map((variation) {
            return ServiceVariationItem(
              serviceFor: service.serviceFor,
              serviceName: service.name,
              serviceDescription: service.description,
              serviceType: service.serviceType,
              serviceGender: service.gender,
              imageUrl: service.imageUrl,
              variations: service.variations, // ✅ LIST
            );
          }),
        ).toList();
  }
}
