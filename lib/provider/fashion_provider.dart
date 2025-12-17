import 'package:flutter/material.dart';
import '../Model/category_model.dart';
import '../Model/service_model.dart';

class FashionProvider extends ChangeNotifier {

  /// 🔹 CATEGORIES (NETWORK IMAGES)
  final List<CategoryModel> categories = [
    CategoryModel(
      id: "womens",
      title: "WOMENS FASHION",
      image:
      "assets/images/woman.jpg",
    ),
    CategoryModel(
      id: "mens",
      title: "MENS FASHION",
      image:
      "assets/images/man.jpg",
    ),
  ];

  /// 🔹 SERVICES (NETWORK IMAGES)
  final List<ServiceModel> services = [

    // =======================
    // 👨 MENS SERVICES
    // =======================

    ServiceModel(
      categoryId: "mens",
      title: "Mens Parlour & Grooming",
      image:
      "assets/images/MensParlour&Grooming.jpg",
      description:
      "Professional grooming services including haircut, styling, and facial treatments.",
      servicesOffered: [
        "Hair Cut",
        "Hair Styling",
        "Facial",
        "Massage",
        "Beard Trim",
        "Manicure",
        "Pedicure",
      ],
      price: "Starting from ₹200",
      buttonText: "Book Appointment",
      contactPhone: "+91 98765 43210",
      contactEmail: "mensparlour@salon.com",
      location: "Main Market, Hazaribagh",
    ),

    ServiceModel(
      categoryId: "mens",
      title: "Mens Hair & Beard Studio",
      image:
      "assets/images/MensHair&BeardStudio.jpg",
      description:
      "Trendy hairstyles, beard styling, hair coloring and premium grooming experience.",
      servicesOffered: [
        "Hair Cut",
        "Beard Styling",
        "Hair Coloring",
        "Head Massage",
        "Hair Spa",
      ],
      price: "Starting from ₹250",
      buttonText: "Book Now",
      contactPhone: "+91 99887 66554",
      contactEmail: "mensstudio@groom.com",
      location: "Ranchi Road, Hazaribagh",
    ),

    ServiceModel(
      categoryId: "mens",
      title: "Mens Spa & Relaxation",
      image:
      "assets/images/MensSpa.png",
      description:
      "Relaxing body spa therapies specially designed for men.",
      servicesOffered: [
        "Full Body Massage",
        "Oil Therapy",
        "Stress Relief Spa",
      ],
      price: "Starting from ₹800",
      buttonText: "Book Spa",
      contactPhone: "+91 90909 12121",
      contactEmail: "mensspa@relax.com",
      location: "Near Lake Area, Hazaribagh",
    ),

    // =======================
    // 👩 WOMENS SERVICES
    // =======================

    ServiceModel(
      categoryId: "womens",
      title: "Womens Salon & Beauty Services",
      image:
      "assets/images/WomensSalon&BeautyServices.jpg",
      description:
      "Complete beauty and hair care services including spa and professional makeup.",
      servicesOffered: [
        "Hair Spa",
        "Makeup",
        "Facial",
        "Threading",
        "Waxing",
      ],
      price: "Starting from ₹300",
      buttonText: "Book Appointment",
      contactPhone: "+91 91234 56789",
      contactEmail: "womenssalon@beauty.com",
      location: "Near Bus Stand, Ranchi Road",
    ),

    ServiceModel(
      categoryId: "womens",
      title: "Bridal Makeup & Makeover",
      image:
      "assets/images/BridalMakeup&Makeover.jpg",
      description:
      "Exclusive bridal makeup, engagement and party makeover services.",
      servicesOffered: [
        "Bridal Makeup",
        "Engagement Makeup",
        "Party Makeup",
        "Hair Styling",
      ],
      price: "Starting from ₹2500",
      buttonText: "Book Bridal",
      contactPhone: "+91 88888 77777",
      contactEmail: "bridal@makeup.com",
      location: "City Center, Hazaribagh",
    ),

    ServiceModel(
      categoryId: "womens",
      title: "Womens Spa & Wellness",
      image:
      "assets/images/WomensSpa&Wellness.jpg",
      description:
      "Relaxing spa therapies for women including skin care and body treatments.",
      servicesOffered: [
        "Body Spa",
        "Facial Therapy",
        "Aromatherapy",
        "Body Polishing",
      ],
      price: "Starting from ₹1200",
      buttonText: "Book Spa",
      contactPhone: "+91 77777 66666",
      contactEmail: "womensspa@wellness.com",
      location: "Near Park Road, Hazaribagh",
    ),
  ];

  /// 🔹 FILTER BY CATEGORY
  List<ServiceModel> getServicesByCategory(String categoryId) {
    return services
        .where((service) => service.categoryId == categoryId)
        .toList();
  }
}
