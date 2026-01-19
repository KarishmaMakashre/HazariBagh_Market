import 'package:flutter/material.dart';
import '../../services/auth_api_service.dart';

class AuthProvider extends ChangeNotifier {
  String mobile = "";
  String otp = "";

  bool loading = false;
  bool otpSent = false;
  bool isLoggedIn = false;

  /// 📱 Set mobile
  void setMobile(String value) {
    mobile = value;
    debugPrint("📱 Mobile entered: $mobile");
    notifyListeners();
  }

  /// 🔐 Set OTP
  void setOtp(String value) {
    otp = value;
    debugPrint("🔐 OTP entered: $otp");
    notifyListeners();
  }

  /// 📤 SEND OTP
  Future<bool> sendOtp() async {
    loading = true;
    notifyListeners();

    final success = await AuthApiService.sendOtp(mobile);

    loading = false;
    otpSent = success;

    notifyListeners();
    return success;
  }

  /// 🔐 VERIFY OTP
  Future<bool> verifyOtp() async {
    loading = true;
    notifyListeners();

    final response = await AuthApiService.verifyOtp(mobile, otp);

    loading = false;

    if (response["success"] == true) {
      isLoggedIn = true;

      /// 🧠 OPTIONAL: save token if backend sends it
      /// AuthApiService.token = response["token"];
    }

    notifyListeners();
    return response["success"] == true;
  }

  /// 🗑 DELETE ACCOUNT (auth clear)
  Future<void> onAccountDeleted() async {
    debugPrint("🗑 Account deleted, clearing auth");

    mobile = "";
    otp = "";
    otpSent = false;
    isLoggedIn = false;

    /// OPTIONAL: clear token
    /// AuthApiService.token = null;

    notifyListeners();
  }

  /// 🚪 LOGOUT
  void logout() {
    debugPrint("🚪 User logged out");

    mobile = "";
    otp = "";
    otpSent = false;
    isLoggedIn = false;

    /// OPTIONAL: clear token
    /// AuthApiService.token = null;

    notifyListeners();
  }

  /// 🔁 FULL RESET
  void reset() {
    mobile = "";
    otp = "";
    otpSent = false;
    isLoggedIn = false;
    notifyListeners();
  }
}
