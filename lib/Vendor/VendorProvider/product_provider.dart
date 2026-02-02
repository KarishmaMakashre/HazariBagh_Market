import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  bool _isLoading = false;
  List<dynamic> _stores = [];

  bool get isLoading => _isLoading;
  List<dynamic> get stores => _stores;

  final String _baseUrl = "https://api.hazaribagmarket.in";

  /// 🔐 TOKEN (DIRECT – NO BEARER)
  final String _token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9."
      "eyJpZCI6IjY5N2RhMzhlMzNmMDI1ZDkxZTAxNjhjYiIsInJvbGUiOiJ2ZW5kb3IiLCJpYXQiOjE3Njk4NDIxNTEsImV4cCI6MTc3NTg5MDE1MX0."
      "4mHdgz0TvDB89y-cuRYjUDiKjEVZG8CdT7ePMFCf510";

  // =====================================================
  // 🔥 CREATE STORE
  // =====================================================
  Future<bool> createVendorStore({
    required String name,
    required String categoryId,
    required String description,
    required String street,
    required String city,
    required String state,
    required String pincode,
    required String landmark,
    required String lat,
    required String lng,
    required String openTime,
    required String closeTime,
    File? storeImage,
    File? shopLicense,
    File? fssai,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final request = http.MultipartRequest(
        "POST",
        Uri.parse("$_baseUrl/vendor/createstore"),
      );

      /// 🔥 AUTH
      request.headers['Authorization'] = _token;

      /// 🧾 TEXT FIELDS
      request.fields.addAll({
        "name": name,
        "category": categoryId,
        "description": description,
        "address.street": street,
        "address.city": city,
        "address.state": state,
        "address.pincode": pincode,
        "address.landmark": landmark,
        "geoLocation.lat": lat,
        "geoLocation.lng": lng,
        "openingHours.open": openTime,
        "openingHours.close": closeTime,
      });

      /// 📸 FILES (ONLY IF EXISTS)
      if (storeImage != null) {
        request.files.add(
          await http.MultipartFile.fromPath("storeImage", storeImage.path),
        );
      }

      if (shopLicense != null) {
        request.files.add(
          await http.MultipartFile.fromPath("shopLicense", shopLicense.path),
        );
      }

      if (fssai != null) {
        request.files.add(
          await http.MultipartFile.fromPath("fssai", fssai.path),
        );
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      debugPrint("CREATE STATUS 👉 ${response.statusCode}");
      debugPrint("CREATE RESPONSE 👉 $responseBody");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = jsonDecode(responseBody);

        /// 🔥 NEW STORE → TOP OF LIST
        if (decoded['store'] != null) {
          _stores.insert(0, decoded['store']);
        }

        _isLoading = false;
        notifyListeners();
        return true;
      }
    } catch (e) {
      debugPrint("CREATE STORE ERROR ❌ $e");
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  // =====================================================
  // 🔥 FETCH STORES
  // =====================================================
  Future<void> fetchVendorStores() async {
    try {
      final response = await http.get(
        Uri.parse("$_baseUrl/vendor/getallstores"),
        headers: {
          "Authorization": _token, // ✅ SINGLE SOURCE
        },
      );

      debugPrint("FETCH STATUS 👉 ${response.statusCode}");
      debugPrint("FETCH RESPONSE 👉 ${response.body}");

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        /// 🔥 SAFE KEY HANDLING
        _stores = decoded['stores'] ??
            decoded['data'] ??
            decoded['store'] ??
            [];

        notifyListeners();
      }
    } catch (e) {
      debugPrint("FETCH STORE ERROR ❌ $e");
    }
  }
}
