class FoodStore {
  final String id;
  final String storeName;
  final String type;
  final String description;
  final Address address;
  final GeoLocation geoLocation;
  final int deliveryRadiusKm;
  final bool isOpen;
  final String status;
  final List<String> foodType;
  final List<String> images;

  FoodStore({
    required this.id,
    required this.storeName,
    required this.type,
    required this.description,
    required this.address,
    required this.geoLocation,
    required this.deliveryRadiusKm,
    required this.isOpen,
    required this.status,
    required this.foodType,
    required this.images,
  });

  factory FoodStore.fromJson(Map<String, dynamic> json) {
    return FoodStore(
      id: json["_id"] ?? "",
      storeName: json["storeName"] ?? "Food Store",
      type: json["type"] ?? "",
      description: json["description"] ?? "",
      address: Address.fromJson(json["address"] ?? {}),
      geoLocation: GeoLocation.fromJson(json["geoLocation"] ?? {}),
      deliveryRadiusKm: json["deliveryRadiusKm"] ?? 0,
      isOpen: json["isOpen"] ?? false,
      status: json["status"] ?? "",
      foodType: List<String>.from(json["foodType"] ?? []),
      images: List<String>.from(json["images"] ?? []),
    );
  }
}

class Address {
  final String line1;
  final String area;
  final String city;
  final String state;
  final String pincode;
  final String country;

  Address({
    required this.line1,
    required this.area,
    required this.city,
    required this.state,
    required this.pincode,
    required this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      line1: json["line1"] ?? "",
      area: json["area"] ?? "",
      city: json["city"] ?? "",
      state: json["state"] ?? "",
      pincode: json["pincode"] ?? "",
      country: json["country"] ?? "",
    );
  }
}

class GeoLocation {
  final double lat;
  final double lng;

  GeoLocation({
    required this.lat,
    required this.lng,
  });

  factory GeoLocation.fromJson(Map<String, dynamic> json) {
    return GeoLocation(
      lat: (json["lat"] ?? 0).toDouble(),
      lng: (json["lng"] ?? 0).toDouble(),
    );
  }
}