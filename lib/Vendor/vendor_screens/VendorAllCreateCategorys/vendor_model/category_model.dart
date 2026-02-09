class Category {
  final String id;
  final String name;
  final String image;
  final bool isActive;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.isActive,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      name: json['name'],
      image: json['image'],
      isActive: json['isActive'],
    );
  }
}
