import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/Vendor/core/api/api_service.dart';

class HotelProvider with ChangeNotifier {
  bool isLoading = false;
  List hotels = [];

  Future<void> getHotels() async {
    isLoading = true;
    notifyListeners();

    try {
      final res = await ApiService.get("/hotelandrestaurent/get");

      if (res.statusCode == 200) {
        hotels = jsonDecode(res.body)['data'] ?? [];
      }
    } catch (e) {
      debugPrint("HOTEL ERROR ❌ $e");
    }

    isLoading = false;
    notifyListeners();
  }
}
