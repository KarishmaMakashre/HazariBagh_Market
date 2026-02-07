import 'package:flutter/material.dart';
import '../VendorAllCreateCategorys/GroceryStoreListScreen.dart';
import '../VendorAllCreateCategorys/VendorFashionProductListScreen.dart';
import '../VendorAllCreateCategorys/VendorPropertyScreen.dart';
import '../VendorAllCreateCategorys/education_detail_screen.dart';
import '../VendorAllCreateCategorys/govt_service_screen.dart';
import '../VendorAllCreateCategorys/vendor_food_store_list_screen.dart';
import '../VendorAllCreateCategorys/vendor_hospital_screen.dart';
import '../VendorAllCreateCategorys/vendor_hotel_screen.dart';
import '../VendorAllCreateCategorys/vendor_job_details_screen.dart';
import '../VendorAllCreateCategorys/vendor_travel_screen.dart';
import '../VendorAllCreateCategorys/vendor_agriculture_screen.dart';
import '../VendorAllCreateCategorys/vendor_automobile_screen.dart';

/// 🔹 Category model
class CategoryModel {
  final String id;
  final String name;
  final String image;
  final bool isActive;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.isActive,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      isActive: json['isActive'] ?? false,
    );
  }
}

/// 🔹 Category name -> asset image
final Map<String, String> categoryAssetMap = {
  "Jobs": "assets/Icons/job.png",
  "Properties": "assets/Icons/rental.png",
  "Food Store": "assets/Icons/food.png",
  "Fashion Store": "assets/Icons/fashion.png",
  "Grocery Store": "assets/Icons/grocery.png",
  "Hotel and Restaurents": "assets/Icons/hotel.png",
  "Educations": "assets/Icons/education.png",
  "Hospitals and Clinics": "assets/Icons/hospital.png",
  "Tour and Travels": "assets/Icons/tour.png",
  "Agriculture": "assets/Icons/agriculture.png",
  "Automobiles": "assets/Icons/Automobile.png",
  "Government Services": "assets/Icons/Government.png",
};

/// 🔹 Category name -> vendor screen
final Map<String, Widget Function(String storeId)> categoryScreenMap = {
  "Jobs": (storeId) => JobListScreen(storeId: storeId),
  "Properties": (storeId) => VendorPropertyScreen(),
  "Food Store": (storeId) => VendorFoodStoreListScreen(),
  "Fashion Store": (storeId) => Vendorfashionproductlistscreen(),
  "Grocery Store": (storeId) => GroceryStoreListScreen(),
  "Hotel and Restaurents": (storeId) => VendorHotelScreen(storeId: storeId),
  "Educations": (storeId) => EducationListScreen(),
  "Hospitals and Clinics": (storeId) => VendorHospitalScreen(storeId: storeId),
  "Tour and Travels": (storeId) => VendorTravelScreen(storeId: storeId),
  "Agriculture": (storeId) => VendorAgricultureScreen(storeId: storeId),
  "Automobiles": (storeId) => VendorAutomobileScreen(storeId: storeId),
  "Government Services": (storeId) => GovtServiceScreen(),
};
