

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../vendor_screens/models/hotel_model.dart';

class VendorHotelProvider extends ChangeNotifier {
  final List<Hotel> _hotels = [];

  List<Hotel> get hotels => _hotels;

  bool isLoading = false;

  void addHotelToList(Hotel hotel) {
    _hotels.add(hotel);
    notifyListeners();
  }

  // ---------------- GET Hotels ----------------
  Future<void> fetchHotels() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse("https://api.hazaribagmarket.in/hotelandrestaurent/get"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer YOUR_TOKEN_HERE", // Add your token
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)["hotels"] ?? [];

        _hotels.clear();
        for (var item in data) {
          _hotels.add(Hotel.fromJson(item));
        }
      } else {
        debugPrint("Failed to load hotels: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching hotels: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  // ---------------- POST Create Hotel ----------------
  Future<Hotel?> createHotel(Map<String, dynamic> hotelData) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse("https://api.hazaribagmarket.in/hotelandrestaurent/create"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer YOUR_TOKEN_HERE", // Add your token
        },
        body: json.encode(hotelData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = json.decode(response.body)["data"];
        final Hotel newHotel = Hotel.fromJson(jsonData);
        _hotels.add(newHotel);
        notifyListeners();
        return newHotel;
      } else {
        debugPrint("Failed to create hotel: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      debugPrint("Error creating hotel: $e");
    }

    isLoading = false;
    notifyListeners();
    return null;
  }
}