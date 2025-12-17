// File: ../provider/hotel_provider.dart

import 'package:flutter/material.dart';
import '../Model/hotel_category_model.dart';
import '../Model/product_model.dart'; // Reusing ProductModel for hotel/restaurant items

class HotelProvider extends ChangeNotifier {

  bool _isLoading = false;
  List<HotelCategoryModel> _categories = [];
  List<ProductModel> _allProducts = []; // Using ProductModel for simplicity

  bool get isLoading => _isLoading;
  List<HotelCategoryModel> get categories => _categories;

  HotelProvider() {
    _loadInitialData();
    _loadProductData();
  }

  /// 🏨 HOTEL/RESTAURANT CATEGORY DATA
  final List<HotelCategoryModel> _initialData = [
    HotelCategoryModel(title: "Hotels", image: "assets/images/bedroom.png"),
    HotelCategoryModel(title: "Restaurants", image: "assets/images/avin-cp-OlXUUQedQyM-unsplash.jpg"),
    HotelCategoryModel(title: "Cafes", image: "assets/images/bedroomSecond.png"),
    HotelCategoryModel(title: "Fine Dining", image: "assets/images/Beverages.jpg"),
    HotelCategoryModel(title: "Fast Food", image: "assets/images/clothe.jpg"),
    HotelCategoryModel(title: "Bakery", image: "assets/images/electronics.jpg"),
  ];

  /// 🍽 DUMMY PRODUCT DATA (Hotels/Restaurants)
  final List<ProductModel> _dummyProducts = [

    // ------------------- VEGETABLES -------------------
    ProductModel(
      name: "Fresh Tomatoes",
      image: "assets/images/avin-cp-OlXUUQedQyM-unsplash.jpg",
      price: "₹40/kg",
      category: "Vegetables",
      storeName: "Sharma Grocery Store",
    ),
    ProductModel(
      name: "Onions (Local)",
      image: "assets/images/vivek-sharma-rDDICrot22U-unsplash.jpg",
      price: "₹25/kg",
      category: "Vegetables",
      storeName: "Sharma Grocery Store",
    ),

    // --------------------- FRUITS ---------------------
    ProductModel(
      name: "Apples (Shimla)",
      image: "assets/images/priscilla-du-preez-CoqJGsFVJtM-unsplash.jpg",
      price: "₹150/kg",
      category: "Fruits",
      storeName: "Sharma Grocery Store",
    ),

    // --------------------- RICE ---------------------
    ProductModel(
      name: "Basmati Rice",
      image: "assets/images/rice.jpg",
      price: "₹120/kg",
      category: "Rice",
      storeName: "Sharma Grocery Store",
    ),

    // --------------------- SNACKS ---------------------
    ProductModel(
      name: "Potato Chips",
      image: "assets/images/snacks.jpg",
      price: "₹30",
      category: "Snacks",
      storeName: "Delicious Food Point",
    ),

    // --------------------- BEVERAGES ---------------------
    ProductModel(
      name: "Soda Pack",
      image: "assets/images/Beverages.jpg",
      price: "₹200",
      category: "Beverages",
      storeName: "Delicious Food Point",
    ),

    // --------------------- SPICES ---------------------
    ProductModel(
      name: "Turmeric Powder",
      image: "assets/images/spices.jpg",
      price: "₹120/100g",
      category: "Spices",
      storeName: "Sharma Grocery Store",
    ),

    // --------------------- PULSES ---------------------
    ProductModel(
      name: "Arhar Dal",
      image: "assets/images/pules.jpg",
      price: "₹110/kg",
      category: "Pulses",
      storeName: "Sharma Grocery Store",
    ),
  ];



  // Asynchronous data load for categories
  Future<void> _loadInitialData() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));

    _categories = _initialData;
    _isLoading = false;
    notifyListeners();
  }

  // Asynchronous data load for products
  Future<void> _loadProductData() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _allProducts = _dummyProducts;
  }

  /// METHOD TO FILTER PRODUCTS FOR HotelProductListScreen
  List<ProductModel> getProductsByCategory(String category) {
    // Filter the comprehensive list based on the category title
    return _allProducts.where((p) => p.category == category).toList();
  }
}