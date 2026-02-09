import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../utils/api_urls.dart';
import '../vendor_model/Vendor_Store_Model.dart';


class VendorStoreProvider with ChangeNotifier {
  bool isLoading = false;
  List<StoreModel> stores = [];

  Future<void> getAllStores() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse(ApiUrls.getAllStores),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        stores = (data['stores'] as List)
            .map((e) => StoreModel.fromJson(e))
            .toList();
      }
    } catch (e) {
      debugPrint('Error fetching stores: $e');
    }

    isLoading = false;
    notifyListeners();
  }
}
