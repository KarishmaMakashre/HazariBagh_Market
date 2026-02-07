class Property {
  final String id;
  final String name;
  final String subCategoryId;
  final String propertyType;
  final String priceType;
  final double priceAmount;
  final String address;
  final String city;
  final String state;
  final double latitude;
  final double longitude;
  final double sizeValue;
  final String sizeUnit;
  final int bedrooms;
  final int bathrooms;
  final int kitchens;
  final int balconies;
  final int floors;
  final String furnishing;
  final String description;
  final List<String> amenities;
  final List<String> images;

  Property({
    required this.id,
    required this.name,
    required this.subCategoryId,
    required this.propertyType,
    required this.priceType,
    required this.priceAmount,
    required this.address,
    required this.city,
    required this.state,
    required this.latitude,
    required this.longitude,
    required this.sizeValue,
    required this.sizeUnit,
    required this.bedrooms,
    required this.bathrooms,
    required this.kitchens,
    required this.balconies,
    required this.floors,
    required this.furnishing,
    required this.description,
    required this.amenities,
    required this.images,
  });

  /// ✅ Factory method to create Property from JSON
  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      subCategoryId: json['subCategoryId'] ?? json['subCategory'] ?? '',
      propertyType: json['propertyType'] ?? '',
      priceType: json['price']?['type'] ?? '',
      priceAmount: (json['price']?['amount'] ?? 0).toDouble(),
      address: json['location']?['address'] ?? '',
      city: json['location']?['city'] ?? '',
      state: json['location']?['state'] ?? '',
      latitude: (json['location']?['latitude'] ?? 0).toDouble(),
      longitude: (json['location']?['longitude'] ?? 0).toDouble(),
      sizeValue: (json['size']?['value'] ?? 0).toDouble(),
      sizeUnit: json['size']?['unit'] ?? '',
      bedrooms: json['bedrooms'] ?? 0,
      bathrooms: json['bathrooms'] ?? 0,
      kitchens: json['kitchens'] ?? 0,
      balconies: json['balconies'] ?? 0,
      floors: json['floors'] ?? 0,
      furnishing: json['furnishing'] ?? '',
      description: json['description'] ?? '',
      amenities: List<String>.from(json['amenities'] ?? []),
      images: List<String>.from(json['images'] ?? []),
    );
  }
}