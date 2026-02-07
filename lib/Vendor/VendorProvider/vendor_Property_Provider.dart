import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../vendor_screens/models/Property_model.dart';

class VendorPropertyProvider extends ChangeNotifier {
  bool isLoading = false;
  final List<Property> _properties = [];
  List<Property> get properties => _properties;


  Future<void> fetchAllProperties() async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await http.get(
        Uri.parse('https://api.hazaribagmarket.in/property/getallproperties'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        _properties.clear();

        for (var item in data['allProperties']) {
          _properties.add(Property.fromJson(item));
        }
      } else {
        debugPrint('Failed to fetch properties: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Fetch Properties Error: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  /// ✅ Add this method
  Future<bool> addProperty({
    required String name,
    required String subCategoryId,
    required String propertyType,
    required String priceType,
    required String priceAmount,
    required String address,
    required String city,
    required String state,
    required double latitude,
    required double longitude,
    required double sizeValue,
    required String sizeUnit,
    required int bedrooms,
    required int bathrooms,
    required int kitchens,
    required int balconies,
    required int floors,
    required String furnishing,
    required String description,
    required String amenities,
    required List<File> images,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      // Simulate API call or local insert
      await Future.delayed(const Duration(seconds: 1));

      final property = Property(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        subCategoryId: subCategoryId,
        propertyType: propertyType,
        priceType: priceType,
        priceAmount: double.tryParse(priceAmount) ?? 0,
        address: address,
        city: city,
        state: state,
        latitude: latitude,
        longitude: longitude,
        sizeValue: sizeValue,
        sizeUnit: sizeUnit,
        bedrooms: bedrooms,
        bathrooms: bathrooms,
        kitchens: kitchens,
        balconies: balconies,
        floors: floors,
        furnishing: furnishing,
        description: description,
        amenities: amenities.split(',').map((e) => e.trim()).toList(),
        images: images.map((e) => e.path).toList(),
      );

      _properties.insert(0, property);
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint("Add Property Error: $e");
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}