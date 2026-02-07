class FashionProduct {
  final String id;
  final String storeName;
  final String storeImage;
  final String shopCategory;
  final List<String> brands;
  final String storeType;

  FashionProduct({
    required this.id,
    required this.storeName,
    required this.storeImage,
    required this.shopCategory,
    required this.brands,
    required this.storeType,
  });

  factory FashionProduct.fromJson(Map<String, dynamic> json) {
    return FashionProduct(
      id: json['_id'] ?? '',
      storeName: json['storeName'] ?? '',
      storeImage: json['storeImage'] ?? '',
      shopCategory: json['shopCategory'] ?? '',
      brands: List<String>.from(json['brandsAvailable'] ?? []),
      storeType: json['storeType'] ?? '',
    );
  }
}