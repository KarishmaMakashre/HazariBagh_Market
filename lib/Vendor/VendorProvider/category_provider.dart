import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryProvider with ChangeNotifier {
  bool _isLoading = false;
  List<dynamic> _categoryList = [];

  bool get isLoading => _isLoading;
  List<dynamic> get categoryList => _categoryList;

  Future<void> getAllCategories() async {
    _isLoading = true;
    notifyListeners();

    final url =
    Uri.parse("https://api.hazaribagmarket.in/category/getall");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        // ✅ CORRECT KEY
        _categoryList = decoded['categories'] ?? [];

        debugPrint("Categories Loaded: ${_categoryList.length}");
      } else {
        debugPrint("API Error: ${response.statusCode}");
        debugPrint(response.body);
      }
    } catch (e) {
      debugPrint("Exception: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
