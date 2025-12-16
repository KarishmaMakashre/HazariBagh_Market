import 'package:flutter/material.dart';
import '../Model/category_model.dart';
import '../Model/service_model.dart';

// -------------------------------------------------------------------
// 🔴 Note: Assuming your ServiceModel is updated with description,
//          contactPhone, contactEmail, and location.
// -------------------------------------------------------------------

class FashionProvider extends ChangeNotifier {

  // 🔹 Categories (Updated to include 'jewelry' and 'kids' for accurate filtering)
  final List<CategoryModel> categories = [
    CategoryModel(
      id: "womens",
      title: "WOMENS FASHION",
      image: "assets/images/woman.jpg",
    ),
    CategoryModel(
      id: "mens",
      title: "MENS FASHION",
      image: "assets/images/man.jpg",
    ),
  ];

  // 🔹 Services (FIXED: Added all required parameters)
  final List<ServiceModel> services = [

    // 👨 MENS - Parlour
    ServiceModel(
      categoryId: "mens",
      title: "Mens Parlour & Grooming",
      image: "assets/images/man.jpg",
      description: "Professional grooming services including hair cut, styling, and relaxing facial treatments.",
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
      // ✅ NEW REQUIRED FIELDS ADDED:
      contactPhone: "+91 98765 43210",
      contactEmail: "mensparlour@salon.com",
      location: "Shop No. 101, Main Market, Hazaribagh",
    ),


    // 👩 WOMENS - Parlour
    ServiceModel(
      categoryId: "womens",
      title: "Womens Salon & Beauty Services",
      image: "assets/images/woman.jpg",
      description: "Complete range of beauty and hair care services including spa treatments and professional makeup.",
      servicesOffered: [
        "Hair Spa",
        "Makeup",
        "Facial",
      ],
      price: "Starting from ₹300",
      buttonText: "Book Appointment",
      // ✅ NEW REQUIRED FIELDS ADDED:
      contactPhone: "+91 91234 56789",
      contactEmail: "womenssalon@beauty.com",
      location: "Near Bus Stand, Ranchi Road",
    ),

  ];

  // 🔹 CATEGORY FILTER METHOD (Unchanged)
  List<ServiceModel> getServicesByCategory(String categoryId) {
    return services
        .where((service) => service.categoryId == categoryId)
        .toList();
  }
}