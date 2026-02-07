class Hotel {
  final String name;
  final String description;
  final Contact contact;
  final Address address;
  final GeoLocation geoLocation;
  final HotelDetails hotelDetails;
  final bool hasRestaurant;
  final Restaurant restaurant;

  Hotel({
    required this.name,
    required this.description,
    required this.contact,
    required this.address,
    required this.geoLocation,
    required this.hotelDetails,
    required this.hasRestaurant,
    required this.restaurant,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      contact: Contact.fromJson(json['contact']),
      address: Address.fromJson(json['address']),
      geoLocation: GeoLocation.fromJson(json['geoLocation']),
      hotelDetails: HotelDetails.fromJson(json['hotelDetails']),
      hasRestaurant: json['hasRestaurant'] ?? false,
      restaurant: Restaurant.fromJson(json['restaurant']),
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "contact": contact.toJson(),
    "address": address.toJson(),
    "geoLocation": geoLocation.toJson(),
    "hotelDetails": hotelDetails.toJson(),
    "hasRestaurant": hasRestaurant,
    "restaurant": restaurant.toJson(),
  };
}

class Contact {
  String phone;
  String email;

  Contact({required this.phone, required this.email});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "phone": phone,
    "email": email,
  };
}

class Address {
  String street, city, state, pincode, landmark;

  Address({
    required this.street,
    required this.city,
    required this.state,
    required this.pincode,
    required this.landmark,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      pincode: json['pincode'] ?? '',
      landmark: json['landmark'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "street": street,
    "city": city,
    "state": state,
    "pincode": pincode,
    "landmark": landmark,
  };
}

class GeoLocation {
  double lat, lng;

  GeoLocation({required this.lat, required this.lng});

  factory GeoLocation.fromJson(Map<String, dynamic> json) {
    return GeoLocation(
      lat: (json['lat'] ?? 0).toDouble(),
      lng: (json['lng'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}

class HotelDetails {
  int totalRooms;
  List<RoomType> roomTypes;
  List<String> amenities;
  String checkInTime;
  String checkOutTime;

  HotelDetails({
    required this.totalRooms,
    required this.roomTypes,
    required this.amenities,
    required this.checkInTime,
    required this.checkOutTime,
  });

  factory HotelDetails.fromJson(Map<String, dynamic> json) {
    return HotelDetails(
      totalRooms: json['totalRooms'] ?? 0,
      roomTypes: (json['roomTypes'] as List)
          .map((e) => RoomType.fromJson(e))
          .toList(),
      amenities: (json['amenities'] as List).map((e) => e.toString()).toList(),
      checkInTime: json['checkInTime'] ?? '',
      checkOutTime: json['checkOutTime'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "totalRooms": totalRooms,
    "roomTypes": roomTypes.map((r) => r.toJson()).toList(),
    "amenities": amenities,
    "checkInTime": checkInTime,
    "checkOutTime": checkOutTime,
  };
}

class RoomType {
  String name;
  double pricePerNight;
  int maxGuests;

  RoomType({
    required this.name,
    required this.pricePerNight,
    required this.maxGuests,
  });

  factory RoomType.fromJson(Map<String, dynamic> json) {
    return RoomType(
      name: json['name'] ?? '',
      pricePerNight: (json['pricePerNight'] ?? 0).toDouble(),
      maxGuests: json['maxGuests'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "pricePerNight": pricePerNight,
    "maxGuests": maxGuests,
  };
}

class Restaurant {
  List<String> cuisines;
  List<String> images;

  Restaurant({required this.cuisines, required this.images});

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      cuisines: (json['cuisines'] as List).map((e) => e.toString()).toList(),
      images: (json['images'] as List).map((e) => e.toString()).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    "cuisines": cuisines,
    "images": images,
  };
}