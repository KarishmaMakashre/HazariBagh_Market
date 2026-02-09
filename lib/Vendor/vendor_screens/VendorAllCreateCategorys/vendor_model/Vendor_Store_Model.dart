class StoreModel {
  final String id;
  final String name;
  final String storeType;
  final String status;

  StoreModel({
    required this.id,
    required this.name,
    required this.storeType,
    required this.status,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['_id'],
      name: json['name'] ??
          json['storeName'] ??
          'Unnamed Store',
      storeType: json['storeType'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
