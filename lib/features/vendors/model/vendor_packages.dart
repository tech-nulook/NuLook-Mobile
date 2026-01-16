class VendorPackages {
  final List<Package> packages;
  final int totalCount;
  final FiltersApplied? filtersApplied;

  VendorPackages({
    required this.packages,
    required this.totalCount,
    this.filtersApplied,
  });

  factory VendorPackages.fromJson(Map<String, dynamic> json) {
    return VendorPackages(
      packages: (json['packages'] as List<dynamic>? ?? [])
          .map((e) => Package.fromJson(e))
          .toList(),
      totalCount: json['total_count'] ?? 0,
      filtersApplied: json['filters_applied'] != null
          ? FiltersApplied.fromJson(json['filters_applied'])
          : null,
    );
  }
}
class Package {
  final int id;
  final String? name;
  final String? description;
  final String? type;
  final int? vendorId;
  final int? categoryId;
  final String? image;
  final String? gender;
  final int? price;
  final int? duration;
  final List<int> serviceIds;
  final List<int> tagIds;
  final List<int> personaIds;
  final List<int> addonServiceIds;
  final bool isAdopted;
  final Vendor? vendor;
  final List<Service> services;
  final int servicesCount;
  final int addonServicesCount;
  final int totalVariations;
  final PriceRange? priceRange;

  Package({
    required this.id,
    this.name,
    this.description,
    this.type,
    this.vendorId,
    this.categoryId,
    this.image,
    this.gender,
    this.price,
    this.duration,
    required this.serviceIds,
    required this.tagIds,
    required this.personaIds,
    required this.addonServiceIds,
    required this.isAdopted,
    this.vendor,
    required this.services,
    required this.servicesCount,
    required this.addonServicesCount,
    required this.totalVariations,
    this.priceRange,
  });

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      type: json['type'],
      vendorId: json['vendor_id'],
      categoryId: json['category_id'],
      image: json['image'],
      gender: json['gender'],
      price: json['price'],
      duration: json['duration'],
      serviceIds: List<int>.from(json['service_ids'] ?? []),
      tagIds: List<int>.from(json['tag_ids'] ?? []),
      personaIds: List<int>.from(json['persona_ids'] ?? []),
      addonServiceIds: List<int>.from(json['addon_service_ids'] ?? []),
      isAdopted: json['is_adopted'] ?? false,
      vendor:
      json['vendor'] != null ? Vendor.fromJson(json['vendor']) : null,
      services: (json['services'] as List<dynamic>? ?? [])
          .map((e) => Service.fromJson(e))
          .toList(),
      servicesCount: json['services_count'] ?? 0,
      addonServicesCount: json['addon_services_count'] ?? 0,
      totalVariations: json['total_variations'] ?? 0,
      priceRange: json['price_range'] != null
          ? PriceRange.fromJson(json['price_range'])
          : null,
    );
  }
}
class Service {
  final int id;
  final String? serviceFor;
  final String? gender;
  final String? serviceType;
  final String? name;
  final String? description;
  final String? imageUrl;
  final List<Variation> variations;

  Service({
    required this.id,
    this.serviceFor,
    this.gender,
    this.serviceType,
    this.name,
    this.description,
    this.imageUrl,
    required this.variations,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      serviceFor: json['service_for'],
      gender: json['gender'],
      serviceType: json['service_type'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['image_url'],
      variations: (json['variations'] as List<dynamic>? ?? [])
          .map((e) => Variation.fromJson(e))
          .toList(),
    );
  }
}

class Variation {
  final int id;
  final String? talentType;
  final int? duration;
  final int? price;

  Variation({
    required this.id,
    this.talentType,
    this.duration,
    this.price,
  });

  factory Variation.fromJson(Map<String, dynamic> json) {
    return Variation(
      id: json['id'],
      talentType: json['talent_type'],
      duration: json['duration'],
      price: json['price'],
    );
  }
}
class Vendor {
  final int id;
  final String? salonName;
  final String? city;
  final String? state;
  final String? logoUrl;
  final String? pocName;
  final String? pocPhn;

  Vendor({
    required this.id,
    this.salonName,
    this.city,
    this.state,
    this.logoUrl,
    this.pocName,
    this.pocPhn,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json['id'],
      salonName: json['salon_name'],
      city: json['city'],
      state: json['state'],
      logoUrl: json['logo_url'],
      pocName: json['poc_name'],
      pocPhn: json['poc_phn'],
    );
  }
}

class PriceRange {
  int? minPrice;
  int? maxPrice;

  PriceRange({this.minPrice, this.maxPrice});

  PriceRange.fromJson(Map<String, dynamic> json) {
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['min_price'] = this.minPrice;
    data['max_price'] = this.maxPrice;
    return data;
  }
}
class FiltersApplied {
  final int? vendorId;
  final String? tag;
  final String? persona;
  final String? gender;
  final String? city;
  final int? minPrice;
  final int? maxPrice;

  FiltersApplied({
    this.vendorId,
    this.tag,
    this.persona,
    this.gender,
    this.city,
    this.minPrice,
    this.maxPrice,
  });

  factory FiltersApplied.fromJson(Map<String, dynamic> json) {
    return FiltersApplied(
      vendorId: json['vendor_id'],
      tag: json['tag'],
      persona: json['persona'],
      gender: json['gender'],
      city: json['city'],
      minPrice: json['min_price'],
      maxPrice: json['max_price'],
    );
  }
}


class ServiceVariationItem {
  final String? serviceFor;
  final String? serviceName;
  final String? serviceDescription;
  final String? serviceType;
  final String? serviceGender;
  final String? imageUrl;
  final List<Variation> variations;

  ServiceVariationItem({
    this.serviceFor,
    this.serviceName,
    this.serviceDescription,
    this.serviceType,
    this.serviceGender,
    this.imageUrl,
    required this.variations,
  });
}