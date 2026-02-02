import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VendorStoreProvider with ChangeNotifier {
  bool isLoading = false;

  /// 🔥 Store list for VendorStoreListScreen
  List<dynamic> storeList = [];

  /// 🔹 CREATE STORE (ONLY THIS API)
  Future<Map<String, dynamic>?> createStore({
    required String name,
    required String category,
    required String description,
    required String street,
    required String city,
    required String state,
    required String landmark,
    required String pincode,
    required String lat,
    required String lng,
    required String openTime,
    required String closeTime,
    required File storeImage,
    required File shopLicense,
    required File fssaiFile,
  }) async {
    try {
      final request = http.MultipartRequest(
        "POST",
        Uri.parse("https://api.hazaribagmarket.in/vendor/createstore"),
      );

      request.headers['token'] =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5N2RhMzhlMzNmMDI1ZDkxZTAxNjhjYiIsInJvbGUiOiJ2ZW5kb3IiLCJpYXQiOjE3Njk4NDIxNTEsImV4cCI6MTc3NTg5MDE1MX0.4mHdgz0TvDB89y-cuRYjUDiKjEVZG8CdT7ePMFCf510';

      request.fields.addAll({
        "name": name,
        "category": category,
        "description": description,
        "street": street,
        "city": city,
        "state": state,
        "landmark": landmark,
        "pincode": pincode,
        "lat": lat,
        "lng": lng,
        "openTime": openTime,
        "closeTime": closeTime,
      });

      request.files.add(
          await http.MultipartFile.fromPath("storeImage", storeImage.path));
      request.files.add(
          await http.MultipartFile.fromPath("shopLicense", shopLicense.path));
      request.files.add(
          await http.MultipartFile.fromPath("fssai", fssaiFile.path));

      final response = await request.send();
      final body = await response.stream.bytesToString();

      debugPrint("CREATE RESPONSE 👉 $body");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(body)['data']; // 🔥 store data
      }
      return null;
    } catch (e) {
      debugPrint("CREATE ERROR ❌ $e");
      return null;
    }
  }

}
