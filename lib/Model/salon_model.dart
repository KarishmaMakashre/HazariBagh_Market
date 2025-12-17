class SalonModel {
  final String image;
  final String name;
  final String rating;
  final String reviews;
  final String location;
  final List<String> services;
  final String phone;

  SalonModel({
    required this.image,
    required this.name,
    required this.rating,
    required this.reviews,
    required this.location,
    required this.services,
    required this.phone,
  });
}