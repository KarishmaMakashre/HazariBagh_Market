class Agriculture {
  final String id;
  final String name;
  final String description;
  final String listingType;
  final double? price;
  final int? quantityAvailable;
  final String? serviceType;
  final double? charge;
  final String? chargeType;
  final String? availability;
  final String serviceMode;
  final List<String> images;
  final List<String> requiredDocuments;
  final String district;
  final String state;
  final String pincode;
  final String country;
  final double lat;
  final double lng;

  Agriculture({
    required this.id,
    required this.name,
    required this.description,
    required this.listingType,
    this.price,
    this.quantityAvailable,
    this.serviceType,
    this.charge,
    this.chargeType,
    this.availability,
    required this.serviceMode,
    required this.images,
    required this.requiredDocuments,
    required this.district,
    required this.state,
    required this.pincode,
    required this.country,
    required this.lat,
    required this.lng,
  });

  factory Agriculture.fromJson(Map<String, dynamic> json) {
    return Agriculture(
      id: json['_id'] ?? "",
      name: json['name'] ?? "",
      description: json['description'] ?? "",
      listingType: json['listingType'] ?? "",
      price: json['productDetails']?['price']?.toDouble(),
      quantityAvailable:
      json['productDetails']?['quantityAvailable'],
      serviceType: json['serviceDetails']?['serviceType'],
      charge: json['serviceDetails']?['charge']?.toDouble(), // ✅ FIXED
      chargeType: json['serviceDetails']?['chargeType'],
      availability: json['serviceDetails']?['availability'],
      serviceMode: json['serviceMode'] ?? "",
      images: json['images'] != null
          ? List<String>.from(json['images'])
          : [],
      requiredDocuments: json['requiredDocuments'] != null
          ? List<String>.from(json['requiredDocuments'])
          : [],
      district: json['address']?['district'] ?? "",
      state: json['address']?['state'] ?? "",
      pincode: json['address']?['pincode'] ?? "",
      country: json['address']?['country'] ?? "",
      lat: json['geoLocation']?['lat']?.toDouble() ?? 0,
      lng: json['geoLocation']?['lng']?.toDouble() ?? 0,
    );
  }
}