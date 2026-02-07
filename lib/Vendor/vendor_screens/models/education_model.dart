class EducationModel {
  final String id;
  final String name;
  final String type;
  final String description;
  final String mode;
  final String address;
  final String city;
  final String state;
  final String pincode;
  final int price;
  final String duration;
  final String schedule;
  final String ageGroup;
  final String language;
  final String phone;
  final String email;
  final List<String> tags;
  final List<String> images;
  final String? imagePath; // for local file

  EducationModel({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.mode,
    required this.address,
    required this.city,
    required this.state,
    required this.pincode,
    required this.price,
    required this.duration,
    required this.schedule,
    required this.ageGroup,
    required this.language,
    required this.phone,
    required this.email,
    required this.tags,
    required this.images,
    this.imagePath,
  });

  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      type: json["type"] ?? "",
      description: json["description"] ?? "",
      mode: json["mode"] ?? "",
      address: json["location"]?["address"] ?? "",
      city: json["location"]?["city"] ?? "",
      state: json["location"]?["state"] ?? "",
      pincode: json["location"]?["pinCode"] ?? "",
      price: json["price"] ?? 0,
      duration: json["duration"] ?? "",
      schedule: json["schedule"] ?? "",
      ageGroup: json["ageGroup"] ?? "",
      language: json["language"] ?? "",
      phone: json["contact"]?["phone"] ?? "",
      email: json["contact"]?["email"] ?? "",
      tags: json["tags"] != null
          ? List<String>.from(json["tags"])
          : [],
      images: json["images"] != null
          ? List<String>.from(json["images"])
          : [],
      imagePath: null, // local file optional
    );
  }
}