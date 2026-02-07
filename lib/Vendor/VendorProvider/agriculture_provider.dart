import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../core/api/api_service.dart';
import '../vendor_screens/models/agriculture_model.dart';

class VendorAgricultureProvider with ChangeNotifier {
  bool isLoading = false;
  List<Agriculture> agricultureList = [];

  Agriculture? _selectedAgriculture;
  Agriculture? get selectedAgriculture => _selectedAgriculture;

  void setAgriculture(Agriculture agri) {
    _selectedAgriculture = agri;
    notifyListeners();
  }

  // ================= FETCH ALL AGRICULTURE =================
  Future<void> fetchAgriculture() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await ApiService.get("agriculture/getall");

      debugPrint("🔍 Fetch Agriculture Response: ${response.body}");

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded['data'] != null) {
          final List<dynamic> data = decoded['data'];
          agricultureList =
              data.map((e) => Agriculture.fromJson(e)).toList();
        }
      } else {
        debugPrint("❌ Failed to fetch agriculture: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("🔥 Exception fetching agriculture: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ================= SUBMIT AGRICULTURE WITH IMAGES =================
  Future<bool> submitAgriculture(Agriculture agriculture) async {
    isLoading = true;
    notifyListeners();

    try {
      // Prepare fields
      final Map<String, String> fields = {
        "name": agriculture.name,
        "categoryId": agriculture.id, // Use actual categoryId
        "description": agriculture.description,
        "listingType": agriculture.listingType,
        "productDetails[price]": agriculture.price.toString(),
        "productDetails[quantityAvailable]":
        agriculture.quantityAvailable.toString(),
        "serviceDetails[serviceType]": agriculture.serviceType ?? "",
        "serviceDetails[charge]": agriculture.charge?.toString() ?? "",
        "serviceDetails[chargeType]": agriculture.chargeType ?? "",
        "serviceDetails[availability]": agriculture.availability ?? "",
        "serviceMode": agriculture.serviceMode,
        "address[district]": agriculture.district,
        "address[state]": agriculture.state,
        "address[pincode]": agriculture.pincode,
        "address[country]": agriculture.country,
        "geoLocation[lat]": agriculture.lat.toString(),
        "geoLocation[lng]": agriculture.lng.toString(),
        "requiredDocuments": agriculture.requiredDocuments.join(", "),
      };

      // Prepare files
      final Map<String, File> files = {};
      for (int i = 0; i < agriculture.images.length; i++) {
        files["images"] = File(agriculture.images[i]);
      }

      final response =
      await ApiService.multipart(endpoint: "agriculture/create", fields: fields, files: files);

      debugPrint("📤 Submit Response: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        debugPrint("✅ Agriculture created successfully: ${data['data']['_id']}");
        return true;
      } else {
        debugPrint("❌ Failed to create agriculture: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      debugPrint("🔥 Exception submitting agriculture: $e");
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}