import 'dart:async';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String mobile = "";
  int otpTimeLeft = 30;
  Timer? _timer;

  void setMobile(String value) {
    mobile = value;
    notifyListeners();
  }

  void sendOtp() {
    debugPrint("OTP Sent to +91$mobile");
    startOtpTimer();
  }

  void googleSignIn() {
    debugPrint("Google Sign In Clicked");
  }

  /// ---------------------------
  /// 🔵 START 30 SEC OTP TIMER
  /// ---------------------------
  void startOtpTimer() {
    otpTimeLeft = 30;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (otpTimeLeft == 0) {
        timer.cancel();
      } else {
        otpTimeLeft--;
      }
      notifyListeners();
    });
  }

  /// ---------------------------
  /// 🔄 RESEND OTP
  /// ---------------------------
  void resendOtp() {
    debugPrint("Resend OTP to +91$mobile");
    startOtpTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
