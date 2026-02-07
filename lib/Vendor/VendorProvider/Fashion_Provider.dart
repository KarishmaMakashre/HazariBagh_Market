import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../vendor_screens/models/Fashion_model.dart';
import '../vendor_screens/utils/api_constants.dart';

class FashionProductProvider with ChangeNotifier {
  static const String baseUrl = ApiConstants.baseUrl;

  List<FashionProduct> _stores = [];
  bool _isLoading = false;
  String? _error;

  List<FashionProduct> get stores => _stores;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// 🔹 GET FASHION STORES
  Future<void> getFashionStores() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse("$baseUrl/vendor/getallstores"),
        headers: ApiConstants.authHeader, // Bearer token
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200 && decoded["success"] == true) {
        final List list = decoded["stores"] ?? [];

        _stores = list
            .where((e) => e["storeType"] == "fashion")
            .map((e) => FashionProduct.fromJson(e))
            .toList();
      } else {
        _error = decoded["message"] ?? "No fashion stores found";
      }
    } catch (e) {
      _error = "Something went wrong";
      debugPrint("❌ Fashion API Error: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  /// 🔹 CLEAR DATA (OPTIONAL)
  void clear() {
    _stores = [];
    notifyListeners();
  }
}