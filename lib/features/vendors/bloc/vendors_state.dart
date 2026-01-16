part of 'vendors_cubit.dart';

sealed class VendorsState extends Equatable {
  const VendorsState();

  @override
  List<Object?> get props => [];
}

final class VendorsInitial extends VendorsState {}

final class VendorsLoading extends VendorsState {}

final class VendorsLoaded extends VendorsState {
  final Vendor? vendor;

  const VendorsLoaded({required this.vendor});

  @override
  List<Object?> get props => [vendor];
}

final class VendorsError extends VendorsState {
  final String message;
  final String? details;

  const VendorsError({required this.message, this.details});

  @override
  List<Object?> get props => [message, details];
}

final class VendorsPackagesLoaded extends VendorsState {
  final VendorPackages? vendorPackages;
  final List<ServiceVariationItem> serviceVariationItem;

  const VendorsPackagesLoaded({required this.vendorPackages, required this.serviceVariationItem});

  VendorsPackagesLoaded copyWith({
    VendorPackages? vendorPackages,
    List<ServiceVariationItem>? serviceVariationItem }) {
    return VendorsPackagesLoaded(
      vendorPackages: vendorPackages ?? this.vendorPackages,
      serviceVariationItem: serviceVariationItem ?? this.serviceVariationItem,
    );
  }

  @override
  List<Object?> get props => [vendorPackages, serviceVariationItem];
}

final class VendorsPackagesError extends VendorsState {
  final String message;
  final String? details;

  const VendorsPackagesError({required this.message, this.details});

  @override
  List<Object?> get props => [message, details];
}