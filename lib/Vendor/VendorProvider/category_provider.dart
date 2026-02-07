import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../vendor_screens/models/category_model.dart';
import '../vendor_screens/utils/ApiEndpoints.dart';

class CategoryProvider with ChangeNotifier {
  bool _isLoading = false;
  List<CategoryModel> _categoryList = [];

  bool get isLoading => _isLoading;
  List<CategoryModel> get categoryList => _categoryList;

  /// 🔹 Fetch data by category name
  Future<void> fetchByCategory(String categoryName) async {
    final endpoint = ApiEndpoints.categoryApiMap[categoryName];

    if (endpoint == null) {
      debugPrint("❌ No API found for $categoryName");
      return;
    }

    _isLoading = true;
    notifyListeners();

    final url = Uri.parse(ApiEndpoints.baseUrl + endpoint);

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        final List list = decoded['data'] ?? decoded['categories'] ?? [];

        _categoryList = list
            .map((e) => CategoryModel.fromJson(e))
            .toList();

        debugPrint("✅ Loaded ${_categoryList.length} items for $categoryName");
      } else {
        debugPrint("❌ API Error ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("❌ Exception: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  /// 🔹 Clear list when switching category
  void clear() {
    _categoryList.clear();
    notifyListeners();
  }

  Future<void> getAllCategories() async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse(
      "https://api.hazaribagmarket.in/vendor/getallstores",
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        final List list = decoded['categories'] ?? [];

        _categoryList =
            list.map((e) => CategoryModel.fromJson(e)).toList();

        debugPrint("✅ Categories Loaded: ${_categoryList.length}");
      } else {
        debugPrint("❌ API Error: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("❌ Exception: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}