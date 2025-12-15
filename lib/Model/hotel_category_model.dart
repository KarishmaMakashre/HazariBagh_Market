
class HotelCategoryModel {
  final String title;
  final String image;
  final String id;

  HotelCategoryModel({
    required this.title,
    required this.image,
    String? id,
  }) : id = id ?? title.toLowerCase().replaceAll(' ', '_');

  // Optional: Factory constructor for JSON/Map if needed later
  factory HotelCategoryModel.fromJson(Map<String, dynamic> json) {
    return HotelCategoryModel(
      title: json['title'] as String,
      image: json['image'] as String,
      id: json['id'] as String,
    );
  }
}