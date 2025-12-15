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
    // ------------------- HOTELS -------------------
    ProductModel(name: "Grand Palace Hotel", image: "assets/images/avin-cp-OlXUUQedQyM-unsplash.jpg", price: "₹4500/Night", category: "Hotels"),
    ProductModel(name: "City Inn Residency", image: "assets/images/bedroom.png", price: "₹2500/Night", category: "Hotels"),

    // ------------------- RESTAURANTS -------------------
    ProductModel(name: "Spice Garden (Indian)", image: "assets/images/bedroomSecond.png", price: "₹800/2-person", category: "Restaurants"),
    ProductModel(name: "Italiano Pizzas", image: "assets/images/Beverages.jpg", price: "₹650/2-person", category: "Restaurants"),

    // --------------------- CAFES ---------------------
    ProductModel(name: "Brew Ha Coffee", image: "assets/images/clothe.jpg", price: "₹300/person", category: "Cafes"),
    ProductModel(name: "The Corner Cafe", image: "assets/images/electronics.jpg", price: "₹250/person", category: "Cafes"),

    // ------------------- FAST FOOD -------------------
    ProductModel(name: "Burger King Outlet", image: "assets/images/eric-prouzet-52DMHPBAvXY-unsplash.jpg", price: "₹400/2-person", category: "Fast Food"),

    // ------------------- Fine Dining -------------------
    ProductModel(name: "The Grand Bistro", image: "assets/images/priscilla-du-preez-CoqJGsFVJtM-unsplash.jpg", price: "₹3000/2-person", category: "Fine Dining"
    ),

    // ------------------- Bakery -------------------
    ProductModel(name: "Artisan Bakehouse", image: "assets/images/pules.jpg", price: "₹600/2-person", category: "Bakery"
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