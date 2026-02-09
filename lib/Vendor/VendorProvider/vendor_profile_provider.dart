import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class VendorProfileProvider extends ChangeNotifier {
  String _shopName = "My Shop";
  String _phone = "9876543210";
  File? _profileImage;

  /// GETTERS
  String get shopName => _shopName;
  String get phone => _phone;
  File? get profileImage => _profileImage;

  /// UPDATE PROFILE DETAILS
  void updateProfile({
    required String shop,
    required String phoneNo,
  }) {
    _shopName = shop;
    _phone = phoneNo;
    notifyListeners();
  }

  /// PICK PROFILE IMAGE
  Future<void> pickProfileImage() async {
    final picker = ImagePicker();
    final pickedFile =
    await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _profileImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  /// REMOVE IMAGE (optional)
  void removeProfileImage() {
    _profileImage = null;
    notifyListeners();
  }
}
