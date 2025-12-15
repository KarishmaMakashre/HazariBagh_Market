class RestaurantModel {
  final String id;
  final String name;
  final String type; // e.g., "Indian • Mughlai • Biryani"
  final String image;
  final String rating;
  final String time; // e.g., "20–30 min"
  final String distance; // e.g., "0.8 km"
  final String category; // e.g., "Indian", "Fast Food", "Cafe"

  RestaurantModel({
    required this.id,
    required this.name,
    required this.type,
    required this.image,
    required this.rating,
    required this.time,
    required this.distance,
    required this.category,
  });
}