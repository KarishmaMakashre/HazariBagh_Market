class GovtModel {
  final String id;
  final String name;
  final String? processingTimeDays;
  final List<String>? requiredDocuments;

  GovtModel({
    required this.id,
    required this.name,
    this.processingTimeDays,
    this.requiredDocuments,
  });

  factory GovtModel.fromJson(Map<String, dynamic> json) {
    return GovtModel(
      id: json['_id'],
      name: json['name'],
      processingTimeDays: json['processingTimeDays'],
      requiredDocuments: json['requiredDocuments'] != null
          ? List<String>.from(json['requiredDocuments'])
          : [],
    );
  }
}