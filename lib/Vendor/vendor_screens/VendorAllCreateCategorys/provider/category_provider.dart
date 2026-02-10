import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../vendor_model/category_model.dart';

class CategoryProvider extends ChangeNotifier {
  List<Category> _categories = [];
  bool isLoading = false;

  List<Category> get categories => _categories;

  Future<void> fetchCategories() async {
    if (_categories.isNotEmpty) return; // prevent reloading

    try {
      isLoading = true;
      notifyListeners();

      final response = await http.get(
        Uri.parse("https://api.hazaribagmarket.in/category/getall"),
      );

      final data = jsonDecode(response.body);

      if (data['success']) {
        _categories = (data['categories'] as List)
            .map((e) => Category.fromJson(e))
            .toList();
      }
    } catch (e) {
      debugPrint("Category fetch error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
