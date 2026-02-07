import 'dart:io';

class StoreModel {
  /// BASIC
  final String name;
  final String description;
  final String city;

  /// CREATE STORE (local file)
  final File? imageFile;

  /// GET STORE (network image)
  final String? imageUrl;

  /// CATEGORY & ADDRESS
  final String categoryId;
  final String street;
  final String state;
  final String pincode;
  final String landmark;

  /// LOCATION
  final double lat;
  final double lng;

  /// TIMING
  final String openTime;
  final String closeTime;

  /// DELIVERY
  final String deliveryType;
  final double perKmCharge;
  final double flatCharge;
  final int maxRadiusKm;
  final int baseDeliveryTime;
  final int timePerKm;

  /// TAX
  final double gstPercent;

  StoreModel({
    required this.name,
    required this.description,
    required this.city,
    this.imageFile,
    this.imageUrl,
    required this.categoryId,
    required this.street,
    required this.state,
    required this.pincode,
    required this.landmark,
    required this.lat,
    required this.lng,
    required this.openTime,
    required this.closeTime,
    required this.deliveryType,
    required this.perKmCharge,
    required this.flatCharge,
    required this.maxRadiusKm,
    required this.baseDeliveryTime,
    required this.timePerKm,
    required this.gstPercent,
  });

  // =====================================================
  // CREATE STORE BODY (for API)
  // =====================================================
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "category": categoryId,
      "address": {
        "street": street,
        "city": city,
        "state": state,
        "pincode": pincode,
        "landmark": landmark,
      },
      "geoLocation": {
        "lat": lat,
        "lng": lng,
      },
      "openingHours": {
        "open": openTime,
        "close": closeTime,
      },
      "delivery": {
        "type": deliveryType,
        "perKmCharge": perKmCharge,
        "flatCharge": flatCharge,
        "maxRadiusKm": maxRadiusKm,
        "baseDeliveryTime": baseDeliveryTime,
        "timePerKm": timePerKm,
      },
      "tax": {
        "gstPercent": gstPercent,
      },
    };
  }

  // =====================================================
  // STORE FROM API RESPONSE
  // =====================================================
  factory StoreModel.fromJson(Map<String, dynamic> json) {
    final address = json['address'] ?? {};
    final geo = json['geoLocation'] ?? {};
    final opening = json['openingHours'] ?? {};
    final delivery = json['delivery'] ?? {};
    final tax = json['tax'] ?? {};

    return StoreModel(
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      city: address['city']?.toString() ?? '',

      /// API image key (adjust if backend changes)
      imageUrl: json['storeImage'] ?? json['shopImage'],

      categoryId: json['category']?.toString() ?? '',
      street: address['street']?.toString() ?? '',
      state: address['state']?.toString() ?? '',
      pincode: address['pincode']?.toString() ?? '',
      landmark: address['landmark']?.toString() ?? '',

      lat: (geo['lat'] is num) ? geo['lat'].toDouble() : 0.0,
      lng: (geo['lng'] is num) ? geo['lng'].toDouble() : 0.0,

      openTime: opening['open']?.toString() ?? '',
      closeTime: opening['close']?.toString() ?? '',

      deliveryType: delivery['type']?.toString() ?? '',
      perKmCharge:
      (delivery['perKmCharge'] is num)
          ? delivery['perKmCharge'].toDouble()
          : 0.0,
      flatCharge:
      (delivery['flatCharge'] is num)
          ? delivery['flatCharge'].toDouble()
          : 0.0,
      maxRadiusKm: delivery['maxRadiusKm'] ?? 0,
      baseDeliveryTime: delivery['baseDeliveryTime'] ?? 0,
      timePerKm: delivery['timePerKm'] ?? 0,

      gstPercent:
      (tax['gstPercent'] is num)
          ? tax['gstPercent'].toDouble()
          : 0.0,
    );
  }
}
