class RestaurantModel {
  final String id;
  final String nameKey;     // 🔑 localization key
  final String typeKey;     // 🔑 localization key
  final String image;
  final String rating;
  final String time;
  final String distance;
  final String categoryKey; // 🔑 localization key

  RestaurantModel({
    required this.id,
    required this.nameKey,
    required this.typeKey,
    required this.image,
    required this.rating,
    required this.time,
    required this.distance,
    required this.categoryKey,
  });
}
