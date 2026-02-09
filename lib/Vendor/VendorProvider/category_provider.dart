import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../vendor_screens/VendorAllCreateCategorys/vendor_model/category_model.dart';
import '../vendor_screens/utils/api_urls.dart';

class VendorCategoryProvider with ChangeNotifier {
  final Box categoryBox;
  final Box registerBox;

  List<Category> categories = [];
  bool isLoading = false;

  VendorCategoryProvider({
    required this.categoryBox,
    required this.registerBox,
  }) {
    loadFromLocal();
    fetchCategories();
  }

  void loadFromLocal() {
    final cached = categoryBox.get('categories');
    if (cached != null) {
      categories = (cached as List)
          .map((e) => Category.fromJson(Map<String, dynamic>.from(e)))
          .toList();
      notifyListeners();
    }
  }

  Future<void> fetchCategories() async {
    try {
      isLoading = true;
      notifyListeners();

      final res = await http.get(Uri.parse(ApiUrls.getAllCategories));

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final List list = data['categories'];

        categories = list.map((e) => Category.fromJson(e)).toList();

        await categoryBox.put('categories', list);
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading = false;
    notifyListeners();
  }

  void selectCategory(Category category) {
    registerBox.put('categoryId', category.id);
    registerBox.put('categoryName', category.name);
    notifyListeners();
  }
}
