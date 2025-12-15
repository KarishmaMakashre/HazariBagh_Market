import 'package:flutter/material.dart';
import '../Model/category_model.dart';
import '../Model/service_model.dart';

class FashionProvider extends ChangeNotifier {

  // 🔹 Categories
  final List<CategoryModel> categories = [
    CategoryModel(
      id: "womens",
      title: "WOMENS",
      image: "assets/images/electronics.jpg",
    ),
    CategoryModel(
      id: "mens",
      title: "MENS",
      image: "assets/images/shopping.png",
    ),
  ];

  // 🔹 Services (CATEGORY WISE)
  final List<ServiceModel> services = [

    // 👨 MENS
    ServiceModel(
      categoryId: "mens",
      title: "Mens Parlour",
      image: "assets/images/clothe.jpg",
      servicesOffered: [
        "Hair Cut",
        "Hair Styling",
        "Facial",
        "Massage",
        "Manicure",
        "Pedicure",
      ],
      price: "Starting from ₹200",
      buttonText: "Book Appointment",
    ),

    ServiceModel(
      categoryId: "mens",
      title: "Mens Clothing",
      image: "assets/images/girl.png",
      servicesOffered: [
        "T-Shirts",
        "Jeans",
        "Formals",
      ],
      price: "Starting from ₹499",
      buttonText: "View Products",
    ),

    // 👩 WOMENS
    ServiceModel(
      categoryId: "womens",
      title: "Womens Parlour",
      image: "assets/images/delivery-man.png",
      servicesOffered: [
        "Hair Spa",
        "Makeup",
        "Facial",
      ],
      price: "Starting from ₹300",
      buttonText: "Book Appointment",
    ),

    ServiceModel(
      categoryId: "womens",
      title: "Womens Clothing",
      image: "assets/images/grocery.jpg",
      servicesOffered: [
        "Sarees",
        "Kurtis",
        "Western Wear",
      ],
      price: "Starting from ₹699",
      buttonText: "View Products",
    ),

    // 💍 JEWELRY
    ServiceModel(
      categoryId: "womens",
      title: "Jewelry Shop",
      image: "assets/images/electronics.jpg",
      servicesOffered: [
        "Gold Jewelry",
        "Silver Jewelry",
        "Diamond Rings",
      ],
      price: "Visit store for pricing",
      buttonText: "Visit Shop",
    ),

    // 🧒 KIDS
    ServiceModel(
      categoryId: "womens",
      title: "Kids Clothing",
      image: "assets/images/job-seeker.png",
      servicesOffered: [
        "Boys Wear",
        "Girls Wear",
      ],
      price: "Starting from ₹299",
      buttonText: "View Products",
    ),
  ];

  // 🔹 CATEGORY FILTER METHOD
  List<ServiceModel> getServicesByCategory(String categoryId) {
    return services
        .where((service) => service.categoryId == categoryId)
        .toList();
  }
}
