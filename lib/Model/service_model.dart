class ServiceModel {
  final String categoryId;
  final String title;
  final String image;
  final List<String> servicesOffered;
  final String price;
  final String buttonText;

  ServiceModel({
    required this.categoryId,
    required this.title,
    required this.image,
    required this.servicesOffered,
    required this.price,
    required this.buttonText,
  });
}
