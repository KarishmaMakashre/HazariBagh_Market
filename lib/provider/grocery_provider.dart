// File: ../provider/grocery_provider.dart

import 'package:flutter/material.dart';
import '../Model/grocery_model.dart';
import '../Model/product_model.dart';

class GroceryProvider extends ChangeNotifier {

  bool _isLoading = false;
  List<GroceryItem> _groceryItems = [];

  List<ProductModel> _allProducts = [];

  bool get isLoading => _isLoading;
  List<GroceryItem> get groceryItems => _groceryItems;

  GroceryProvider() {
    _loadInitialData();
    _loadProductData();
  }

  ///  GROCERY CATEGORY DATA
  final List<GroceryItem> _initialData = [
    GroceryItem(title: "Vegetables", image: "assets/images/clothe.jpg"),
    GroceryItem(title: "Fruits", image: "assets/images/delivery-man.png"),
    GroceryItem(title: "Rice", image: "assets/images/electronics.jpg"),
    // 🔑 Note: Corrected case/spelling for exact matching
    GroceryItem(title: "Wheat", image: "assets/images/flashImg.jpg"),
    GroceryItem(title: "Oil", image: "assets/images/girl.png"),
    // 🔑 Note: Corrected case/spelling for exact matching
    GroceryItem(title: "Milk", image: "assets/images/grocery.jpg"),
    GroceryItem(title: "Snacks", image: "assets/images/job-seeker.png"),
    // 🔑 Note: Corrected case/spelling for exact matching
    GroceryItem(title: "Beverages", image: "assets/images/rental.png"),
    GroceryItem(title: "Spices", image: "assets/images/shopping.png"),
    // 🔑 Note: Corrected case/spelling for exact matching
    GroceryItem(title: "Pulses", image: "assets/images/clothe.jpg"),
  ];

  /// 🥦 DUMMY PRODUCT DATA (Simulating API fetch for actual items)
  final List<ProductModel> _dummyProducts = [
    // ------------------- VEGETABLES -------------------
    ProductModel(name: "Fresh Tomatoes", image: "assets/images/avin-cp-OlXUUQedQyM-unsplash.jpg", price: "₹40/kg", category: "Vegetables"),
    ProductModel(name: "Onions (Local)", image: "assets/images/vivek-sharma-rDDICrot22U-unsplash.jpg", price: "₹25/kg", category: "Vegetables"),
    ProductModel(name: "Potatoes (New)", image: "assets/images/eric-prouzet-52DMHPBAvXY-unsplash.jpg", price: "₹30/kg", category: "Vegetables"),
    ProductModel(name: "Green Chillies", image: "assets/images/steve-johnson-L2xhGmPmMNs-unsplash.jpg", price: "₹80/kg", category: "Vegetables"),

    // --------------------- FRUITS ---------------------
    ProductModel(name: "Apples (Shimla)", image: "assets/images/priscilla-du-preez-CoqJGsFVJtM-unsplash.jpg", price: "₹150/kg", category: "Fruits"),
    ProductModel(name: "Bananas (Dozen)", image: "assets/images/giorgio-trovato-fczCr7MdE7U-unsplash.jpg", price: "₹50/dozen", category: "Fruits"),

    // --------------------- RICE ---------------------
    // 🔑 Category must match "Rice"
    ProductModel(name: "Basmati Rice", image: "assets/images/rice.jpg", price: "₹120/kg", category: "Rice"),

    // --------------------- WHEAT ---------------------
    // 🔑 Category must match "Wheat"
    ProductModel(name: "Whole Wheat", image: "assets/images/whete.jpg", price: "₹45/kg", category: "Wheat"),

    // --------------------- OIL ---------------------
    // 🔑 Category must match "Oil"
    ProductModel(name: "Mustard Oil", image: "assets/images/oil.jpg", price: "₹150/L", category: "Oil"),

    // --------------------- MILK ---------------------
    // 🔑 Category must match "Milk"
    ProductModel(name: "Dairy Milk", image: "assets/images/milk.jpg", price: "₹60/L", category: "Milk"),

    // --------------------- SNACKS ---------------------
    // 🔑 Category must match "Snacks"
    ProductModel(name: "Potato Chips", image: "assets/images/snacks.jpg", price: "₹30", category: "Snacks"),

    // --------------------- BEVERAGES ---------------------
    // 🔑 Category must match "Beverages"
    ProductModel(name: "Soda Pack", image: "assets/images/Beverages.jpg", price: "₹200", category: "Beverages"),

    // --------------------- SPICES ---------------------
    // 🔑 Category must match "Spices"
    ProductModel(name: "Turmeric Powder", image: "assets/images/spices.jpg", price: "₹120/100g", category: "Spices"),

    // --------------------- PULSES ---------------------
    // 🔑 Category must match "Pulses"
    ProductModel(name: "Arhar Dal", image: "assets/images/pules.jpg", price: "₹110/kg", category: "Pulses"),
  ];


  // Asynchronous data load for categories
  Future<void> _loadInitialData() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));

    _groceryItems = _initialData;
    _isLoading = false;
    notifyListeners();
  }

  // Asynchronous data load for products
  Future<void> _loadProductData() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _allProducts = _dummyProducts;
  }

  // Future method to refresh data (e.g., pulling down to refresh)
  Future<void> refreshItems() async {
    await _loadInitialData();
    await _loadProductData();
  }

  /// METHOD TO FILTER PRODUCTS FOR ProductListScreen
  List<ProductModel> getProductsByCategory(String category) {
    // Filter the comprehensive list based on the category title
    return _allProducts.where((p) => p.category == category).toList();
  }
}