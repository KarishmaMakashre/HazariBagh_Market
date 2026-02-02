import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/Vendor/core/api/api_service.dart';

class FashionProvider extends ChangeNotifier {
  bool isLoading = false;

  Future<bool> createFashionProduct({
    required String storeId,
    required String title,
    required String price,
    required String mrp,
    required String gender,
    required String categoryId,
    required String subCategoryId,
    required String sizes,
    required String colors,
    required String clothSize,
    String? pantSize,
    String? shoeSize,
    required File image,
  }) async {
    isLoading = true;
    notifyListeners();

    final response = await ApiService.multipart(
      endpoint: "product/createfashionproduct",
      fields: {
        "storeId": storeId,
        "title": title,
        "price": price,
        "mrp": mrp,
        "gender": gender,
        "categoryId": categoryId,
        "subCategoryId": subCategoryId,
        "sizes": sizes,
        "colors": colors,
        "clothSize": clothSize,
        if (pantSize != null) "pantSize": pantSize,
        if (shoeSize != null) "shoeSize": shoeSize,
      },
      files: {
        "fashionproductimage": image,
      },
    );

    isLoading = false;
    notifyListeners();

    return response.statusCode == 200 || response.statusCode == 201;
  }
}
