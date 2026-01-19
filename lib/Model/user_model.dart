class UserModel {
  final String id;
  final String name;
  final String phone;
  final String? gender;
  final String? profile;
  final String? dob;

  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    this.gender,
    this.profile,
    this.dob,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      gender: json['gender'],
      profile: json['profile'],
      dob: json['dob'],
    );
  }
}
