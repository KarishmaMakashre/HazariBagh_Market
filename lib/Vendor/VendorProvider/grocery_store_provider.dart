import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/Vendor/core/api/api_service.dart';

import '../vendor_screens/models/Grocery_store_Model.dart';

class GroceryStoreProvider with ChangeNotifier {
  List<GroceryStore> _products = [];
  bool _isLoading = false;

  List<GroceryStore> get products => _products;
  bool get isLoading => _isLoading;

  /// 🔹 GET PRODUCTS
  Future<void> fetchGroceryProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response =
      await ApiService.get("product/getall");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List list = data['products'];

        _products =
            list.map((e) => GroceryStore.fromJson(e)).toList();
      }
    } catch (e) {
      print("❌ Fetch error: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  /// 🔹 CREATE PRODUCT
  Future<bool> createProduct({
    required String name,
    required String description,
    required String mrp,
    required String sellingPrice,
    required String quantity,
    required String stock,
    required String unit,
    required String categoryId,
    required String subCategoryId,
    required String storeId,
    required File image,
  }) async {
    try {
      print("📤 Creating product...");

      final response = await ApiService.multipart(
        endpoint: "product/create",
        fields: {
          "name": name,
          "description": description,
          "mrp": mrp,
          "sellingPrice": sellingPrice,
          "quantity": quantity,
          "stock": stock,
          "unit": unit,
          "categoryId": categoryId,
          "subCategoryId": subCategoryId,
          "storeId": storeId,
          "lowStockAlert": "5",
        },
        files: {
          "images": image,
        },
      );

      print("📥 Status Code: ${response.statusCode}");
      print("📥 Response: ${response.body}");

      if (response.statusCode == 200 ||
          response.statusCode == 201) {
        print("✅ Product created successfully");

        await fetchGroceryProducts();
        return true;
      } else {
        print("❌ Product creation failed");
        return false;
      }
    } catch (e) {
      print("🚨 Error creating product: $e");
      return false;
    }
  }
}
