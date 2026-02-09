import 'dart:typed_data';
import 'package:flutter/material.dart';

class VendorRegisterProvider extends ChangeNotifier {
  bool isLoading = false;

  Future<bool> registerVendor({
    required String name,
    required String email,
    required String phone,

    required String storeName,
    required String description,
    required String storeType,

    required String street,
    required String city,
    required String state,
    required String pincode,
    required String landmark,
    required String lat,
    required String lng,

    required String accountHolderName,
    required String accountNumber,
    required String ifsc,
    required String bankName,

    Uint8List? profileImage,
    Uint8List? shopImage,
    Uint8List? aadharDoc,
    Uint8List? panDoc,
    Uint8List? gstDoc,
    Uint8List? shopLicense,
    Uint8List? fssaiDoc,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      /// 🔹 SIMULATE API CALL
      await Future.delayed(const Duration(seconds: 2));

      debugPrint("Vendor Registered:");
      debugPrint("Name: $name");
      debugPrint("Email: $email");
      debugPrint("Store: $storeName");
      debugPrint("Store Type: $storeType");

      /// Here you will:
      /// - Create MultipartRequest
      /// - Attach fields
      /// - Attach files (profileImage, docs etc.)

      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint("Register error: $e");
      isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
