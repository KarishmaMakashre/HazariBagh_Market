import 'package:flutter/material.dart';

import '../screen/All Categories/Property/property_listing_screen.dart';
import '../screen/All Categories/agriculture_screen.dart';
import '../screen/All Categories/automobile_screen.dart';
import '../screen/All Categories/education_screen.dart';
import '../screen/All Categories/fashion/fashion_screen.dart';
import '../screen/All Categories/food/food_screen.dart';
import '../screen/All Categories/government_screen.dart';
import '../screen/All Categories/Grocery/grocery_screen.dart';
import '../screen/All Categories/hardware_screen.dart';
import '../screen/All Categories/home_purchase_screen.dart';
import '../screen/All Categories/hospital_screen.dart';
import '../screen/All Categories/job/jobs_services_screen.dart';
import '../screen/All Categories/plot_screen.dart';
import '../screen/All Categories/services_screen.dart';
import '../screen/All Categories/transport_screen.dart';
import '../screen/All Categories/travel_screen.dart';
import '../screen/All Categories/water_screen.dart';
import '../screen/All Categories/wholesale_screen.dart';
import '../screen/All Categories/hotel/hotel_screen.dart';


class HomeCategoryModel {
  final String image;
  final String title;
  final Widget screen;

  HomeCategoryModel({
    required this.image,
    required this.title,
    required this.screen,
  });
}

final List<HomeCategoryModel> homeCategories = [
  HomeCategoryModel(
    image: "assets/Icons/job.png",
    title: "Jobs in Hazaribagh",
    screen: const JobsServicesScreen(),
  ),

  HomeCategoryModel(
    image: "assets/Icons/rental.png",
    title: "Rental Property",
    screen: const PropertyListingScreen(),
  ),

  HomeCategoryModel(
    image: "assets/Icons/food.png",
    title: "Online Food Delivery",
    screen: const FoodHomeScreen(),
  ),

  HomeCategoryModel(
    image: "assets/Icons/fashion.png",
    title: "Fashion Store",
    screen: const FashionScreen(),
  ),

  HomeCategoryModel(
    image: "assets/Icons/grocery.png",
    title: "Grocery Store",
    screen: const GroceryScreen(),
  ),


  HomeCategoryModel(
    image: "assets/Icons/hotel.png",
    title: "Hotels & Restaurants",
    screen: const HotelScreen(),
  ),

  HomeCategoryModel(
    image: "assets/Icons/20lWater.png",
    title: "20L Water",
    screen: const WaterScreen(),
  ),

  HomeCategoryModel(
    image: "assets/Icons/education.png",
    title: "Education",
    screen: const EducationScreen(),
  ),

  HomeCategoryModel(
    image: "assets/Icons/hospital.png",
    title: "Hospital & Clinic",
    screen: const HospitalScreen(),
  ),

  HomeCategoryModel(
    image: "assets/Icons/wholesale.png",
    title: "Wholesale Suppliers",
    screen: const WholesaleScreen(),
  ),

  HomeCategoryModel(
    image: "assets/Icons/tour.png",
    title: "Tour & Travels",
    screen: const TravelScreen(),
  ),

  HomeCategoryModel(
    image: "assets/Icons/hardware.png",
    title: "Hardware Store",
    screen: const HardwareScreen(),
  ),

  HomeCategoryModel(
    image: "assets/Icons/purchase.png",
    title: "Purchase Plot & Land",
    screen: const PlotScreen(),
  ),

  HomeCategoryModel(
    image: "assets/images/purchaseFlat.png",
    title: "Purchase Flat & Home",
    screen: const HomePurchaseScreen(),
  ),

  HomeCategoryModel(
    image: "assets/Icons/professional.png",
    title: "Professional Services",
    screen: const ServicesScreen(),
  ),

  HomeCategoryModel(
    image: "assets/Icons/Automobile.png",
    title: "Automobile",
    screen: const AutomobileScreen(),
  ),

  HomeCategoryModel(
    image: "assets/Icons/Government.png",
    title: "Government Services",
    screen: const GovernmentScreen(),
  ),

  HomeCategoryModel(
    image: "assets/Icons/transporation.png",
    title: "Transportation",
    screen: const TransportScreen(),
  ),

  HomeCategoryModel(
    image: "assets/Icons/agriculture.png",
    title: "Agriculture",
    screen: const AgricultureScreen(),
  ),

];
