import 'package:flutter/material.dart';
import '../Model/hotel_category_model.dart';
import '../Model/restaurant_model.dart';

class FoodProvider extends ChangeNotifier {

  bool _isLoading = false;
  List<HotelCategoryModel> _categories = []; // The grid items (Hotel, Restaurant, Cafe, etc.)

  List<RestaurantModel> _allRestaurants = []; // The comprehensive list of all restaurants/hotels

  bool get isLoading => _isLoading;
  List<HotelCategoryModel> get categories => _categories;
  List<RestaurantModel> get allRestaurants => _allRestaurants; // Optional getter for all items

  FoodProvider() {
    _loadInitialData(); // Load categories
    _loadRestaurantData(); // Load all restaurants/hotels
  }

  /// 🏨 HOTEL/RESTAURANT CATEGORY DATA
  final List<HotelCategoryModel> _initialCategoryData = [
    // Ensure the title here exactly matches the 'category' in RestaurantModel
    HotelCategoryModel(title: "All", image: "assets/images/avin-cp-OlXUUQedQyM-unsplash.jpg"),
    HotelCategoryModel(title: "Hotel", image: "assets/images/bedroom.png"),
    HotelCategoryModel(title: "Restaurant", image: "assets/images/Beverages.jpg"),
    HotelCategoryModel(title: "Fast Food", image: "assets/images/clothe.jpg"),
    HotelCategoryModel(title: "Cafe", image: "assets/images/electronics.jpg"),
    HotelCategoryModel(title: "Bakery", image: "assets/images/eric-prouzet-52DMHPBAvXY-unsplash.jpg"),
    HotelCategoryModel(title: "Bar", image: "assets/images/giorgio-trovato-fczCr7MdE7U-unsplash.jpg"),
    HotelCategoryModel(title: "Sweets", image: "assets/images/grocery.jpg"),
  ];

  /// 🍽 DUMMY RESTAURANT/HOTEL DATA (Simulating API fetch)
  final List<RestaurantModel> _dummyRestaurantData = [
    // ------------------- HOTEL -------------------
    RestaurantModel(
      id: 'h1', name: "Hotel Grand Palace", type: "Luxury • Buffet", image: "assets/images/hotel.jpg", rating: "4.8", time: "5-10 min", distance: "2.1 km", category: "Hotel",
    ),
    // ------------------- RESTAURANT -------------------
    RestaurantModel(
      id: 'r1', name: "Spice Paradise", type: "Indian • Mughlai • Biryani", image: "assets/images/kitchan.png", rating: "4.5", time: "20–30 min", distance: "0.8 km", category: "Restaurant",
    ),
    RestaurantModel(
      id: 'r2', name: "Chinese Wok", type: "Authentic Chinese", image: "assets/images/milk.jpg", rating: "4.2", time: "30–40 min", distance: "1.5 km", category: "Restaurant",
    ),
    // ------------------- FAST FOOD -------------------
    RestaurantModel(
      id: 'f1', name: "Pizza Corner", type: "Fast Food • Pizzas", image: "assets/images/oil.jpg", rating: "4.3", time: "25–35 min", distance: "1.2 km", category: "Fast Food",
    ),
    RestaurantModel(
      id: 'f2', name: "Burger King", type: "Burgers • Sides", image: "assets/images/pules.jpg", rating: "4.0", time: "15–25 min", distance: "0.5 km", category: "Fast Food",
    ),
    // ------------------- CAFE -------------------
    RestaurantModel(
      id: 'c1', name: "The Coffee Shop", type: "Cafe • Snacks • Beverages", image: "assets/images/rental.png", rating: "4.6", time: "18–28 min", distance: "0.5 km", category: "Cafe",
    ),
    // ------------------- BAKERY -------------------
    RestaurantModel(
      id: 'b1', name: "Fresh Bakes", type: "Cakes • Pastries", image: "assets/images/rice.jpg", rating: "4.7", time: "10–20 min", distance: "1.0 km", category: "Bakery",
    ),
    // ------------------- SWEETS -------------------
    RestaurantModel(
      id: 's1', name: "Gupta Sweets", type: "Indian Sweets • Desserts", image: "assets/images/snacks.jpg", rating: "4.9", time: "10–20 min", distance: "0.4 km", category: "Sweets",
    ),
  ];


  // Asynchronous data load for categories
  Future<void> _loadInitialData() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));

    _categories = _initialCategoryData;
    _isLoading = false;
    notifyListeners();
  }

  // Asynchronous data load for all restaurants/hotels
  Future<void> _loadRestaurantData() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _allRestaurants = _dummyRestaurantData;
  }

  // Future method to refresh data (e.g., pulling down to refresh)
  Future<void> refreshItems() async {
    await _loadInitialData();
    await _loadRestaurantData();
  }

  /// METHOD TO FILTER RESTAURANTS FOR RestaurantListScreen
  List<RestaurantModel> getRestaurantsByCategory(String categoryTitle) {
    if (categoryTitle.toLowerCase() == 'all') {
      return _allRestaurants;
    }

    // Filter the comprehensive list based on the category title
    return _allRestaurants.where((r) => r.category.toLowerCase() == categoryTitle.toLowerCase()).toList();
  }
}