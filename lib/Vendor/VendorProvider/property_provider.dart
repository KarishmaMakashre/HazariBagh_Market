import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/Vendor/core/api/api_service.dart';
import 'package:http/http.dart';

class PropertyProvider with ChangeNotifier {
  bool isLoading = false;
  List properties = [];

  Future<void> getAllProperties() async {
    isLoading = true;
    notifyListeners();

    try {
      final res = await ApiService.get("/property/getallproperties");

      if (res.statusCode == 200) {
        properties = jsonDecode(res.body)['data'] ?? [];
      }
    } catch (e) {
      debugPrint("PROPERTY ERROR ❌ $e");
    }

    isLoading = false;
    notifyListeners();
  }
}
