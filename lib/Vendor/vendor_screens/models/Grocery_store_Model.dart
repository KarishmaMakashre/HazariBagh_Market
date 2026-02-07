class GroceryStore {
  final String id;
  final String name;
  final List<String> images;
  final int sellingPrice;
  final int stock;
  final String unit;
  final String category;
  final String subCategory;
  final String vendorName;

  GroceryStore({
    required this.id,
    required this.name,
    required this.images,
    required this.sellingPrice,
    required this.stock,
    required this.unit,
    required this.category,
    required this.subCategory,
    required this.vendorName,
  });

  factory GroceryStore.fromJson(Map<String, dynamic> json) {
    return GroceryStore(
      id: json['_id'],
      name: json['name'],
      images: List<String>.from(json['images'] ?? []),
      sellingPrice: json['sellingPrice'],
      stock: json['stock'],
      unit: json['unit'],
      category: json['category']?['name'] ?? '',
      subCategory: json['subCategory']?['name'] ?? '',
      vendorName: json['vendorId']?['name'] ?? '',
    );
  }
}
