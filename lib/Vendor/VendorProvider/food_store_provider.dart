import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import '../core/api/api_service.dart';
import '../vendor_screens/models/food_store_model.dart';

class FoodStoreProvider extends ChangeNotifier {
  bool isLoading = false;
  String? error;

  final List<FoodStore> _stores = [];
  List<FoodStore> get stores => _stores;

  /// ================= CREATE FOOD STORE =================
  Future<bool> createFoodStore({
    required String storeName,
    required String type,
    required String description,

    // address
    required String line1,
    required String area,
    required String city,
    required String state,
    required String pincode,
    required String country,

    // geo
    required String lat,
    required String lng,
    required String deliveryRadiusKm,

    required bool isOpen,
    required List<String> foodType,
    required String category,
    required List<File> images,
  }) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      /// 🔥 EXACT BACKEND FIELD KEYS (Postman matched)
      final fields = <String, String>{
        "storeName": storeName,
        "type": type,
        "description": description,

        "address[line1]": line1,
        "address[area]": area,
        "address[city]": city,
        "address[state]": state,
        "address[pincode]": pincode,
        "address[country]": country,

        "geoLocation[lat]": lat,
        "geoLocation[lng]": lng,

        "deliveryRadiusKm": deliveryRadiusKm,
        "isOpen": isOpen ? "Yes" : "No",

        /// backend expects array → send first item
        "foodType": foodType.first,

        "category": category,
      };

      /// 🔥 MULTIPLE IMAGES
      final Map<String, File> files = {};
      for (int i = 0; i < images.length; i++) {
        files["images"] = images[i]; // backend accepts same key
      }

      final response = await ApiService.multipart(
        endpoint: "foodstore/createfoodstore",
        fields: fields,
        files: files,
      );

      debugPrint("STATUS CODE: ${response.statusCode}");
      debugPrint("RESPONSE: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        if (json["success"] == true) {
          return true;
        } else {
          error = json["message"] ?? "Something went wrong";
          return false;
        }
      } else {
        error = "Server Error ${response.statusCode}";
        return false;
      }
    } catch (e) {
      error = e.toString();
      debugPrint("CREATE STORE ERROR: $e");
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// ================= GET ALL FOOD STORES =================
  Future<void> getAllFoodStores() async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      final response =
      await ApiService.get("foodstore/getallfoodstores");

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List data = json["data"];

        _stores.clear();
        _stores.addAll(
          data.map((e) => FoodStore.fromJson(e)).toList(),
        );
      } else {
        error = "Failed to load stores";
      }
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}