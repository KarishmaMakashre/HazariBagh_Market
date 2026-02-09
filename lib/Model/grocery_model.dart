class GroceryItem {
  final String title;
  final String image;
  // Optional: Add a unique ID for better data handling
  final String id;

  GroceryItem({
    required this.title,
    required this.image,
    // Using title as a simple ID for now, but a real ID is better
    String? id,
  }) : id = id ?? title.toLowerCase().replaceAll(' ', '_');

  // Optional: Method to create a vendor_model from JSON/Map if fetching from an API
  factory GroceryItem.fromJson(Map<String, dynamic> json) {
    return GroceryItem(
      title: json['title'] as String,
      image: json['image'] as String,
      id: json['id'] as String,
    );
  }
}