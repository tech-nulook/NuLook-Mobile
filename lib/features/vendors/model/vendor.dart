
class Vendor {
  final List<Vendors> vendors;
  final int totalCount;

  Vendor({
    required this.vendors,
    required this.totalCount,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      vendors: (json['vendors'] as List<dynamic>? ?? [])
          .map((e) => Vendors.fromJson(e))
          .toList(),
      totalCount: json['total_count'] ?? 0,
    );
  }
}

class Vendors {
  final int id;
  final String? salonName;
  final String? description;
  final String? logoUrl;
  final List<Photo> photos;
  final String? pocName;
  final String? pocPhn;
  final String? address;
  final String? city;
  final String? state;
  final String? pincode;
  final String? landmark;
  final DateTime? joinedOn;
  final String? salonFor;
  final List<int> serviceInfo;
  final String? status;
  final String? isClient;
  final List<Availability> availabilities;
  final int servicesCount;
  final int packagesCount;

  Vendors({
    required this.id,
    this.salonName,
    this.description,
    this.logoUrl,
    required this.photos,
    this.pocName,
    this.pocPhn,
    this.address,
    this.city,
    this.state,
    this.pincode,
    this.landmark,
    this.joinedOn,
    this.salonFor,
    required this.serviceInfo,
    this.status,
    this.isClient,
    required this.availabilities,
    required this.servicesCount,
    required this.packagesCount,
  });

  factory Vendors.fromJson(Map<String, dynamic> json) {
    return Vendors(
      id: json['id'],
      salonName: json['salon_name'],
      description: json['description'],
      logoUrl: json['logo_url'],
      photos: (json['photos'] as List<dynamic>? ?? [])
          .map((e) => Photo.fromJson(e))
          .toList(),
      pocName: json['poc_name'],
      pocPhn: json['poc_phn'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      pincode: json['pincode'],
      landmark: json['landmark'],
      joinedOn: json['joined_on'] != null
          ? DateTime.parse(json['joined_on'])
          : null,
      salonFor: json['salon_for'],
      serviceInfo: List<int>.from(json['service_info'] ?? []),
      status: json['status'],
      isClient: json['is_client'],
      availabilities: (json['availabilities'] as List<dynamic>? ?? [])
          .map((e) => Availability.fromJson(e))
          .toList(),
      servicesCount: json['services_count'] ?? 0,
      packagesCount: json['packages_count'] ?? 0,
    );
  }

  /// ✅ Useful helper for UI
  String get fullAddress => [
    address,
    landmark,
    city,
    state,
    pincode,
  ].where((e) => e != null && e!.trim().isNotEmpty).join(', ');
}

class Photo {
  final int id;
  final String? url;

  Photo({required this.id, this.url});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      url: json['url'],
    );
  }
}

class Availability {
  final int id;
  final int vendorId;
  final List<String> days;
  final String? timeFrom;
  final String? timeTo;

  Availability({
    required this.id,
    required this.vendorId,
    required this.days,
    this.timeFrom,
    this.timeTo,
  });

  factory Availability.fromJson(Map<String, dynamic> json) {
    return Availability(
      id: json['id'],
      vendorId: json['vendor_id'],
      days: List<String>.from(json['days'] ?? []),
      timeFrom: json['time_from'],
      timeTo: json['time_to'],
    );
  }
}

String formatSalonAddress(Map<String, dynamic> json) {
  return [
    json['address'],
    json['landmark'],
    json['city'],
    json['state'],
    json['pincode'],
  ]
      .where((e) => e != null && e.toString().trim().isNotEmpty)
      .join(', ');
}


