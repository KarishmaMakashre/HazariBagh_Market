
class ServiceModel {
  final String categoryId;
  final String title;
  final String image;
  final String description; // Description added for details screen
  final List<String> servicesOffered;
  final String price;
  final String buttonText;

  // New fields for Fashion/Service details:
  final String contactPhone; // New
  final String contactEmail; // New
  final String location;     // New (e.g., Shop address or online)

  ServiceModel({
    required this.categoryId,
    required this.title,
    required this.image,
    required this.description,
    required this.servicesOffered,
    required this.price,
    required this.buttonText,
    required this.contactPhone,
    required this.contactEmail,
    required this.location,
  });
}