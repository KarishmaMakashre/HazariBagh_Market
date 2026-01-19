import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../Model/user_profile_response.dart';

class AuthApiService {
  static const String baseUrl = "http://172.20.10.3:5678";

  /// 🔐 AUTH TOKEN
  static String token = "";

  /// ✅ SET TOKEN AFTER OTP VERIFY
  static void setToken(String newToken) {
    token = newToken;
    debugPrint("🔐 Token Saved: $token");
  }

  /// 📤 SEND OTP
  static Future<bool> sendOtp(String phone) async {
    try {
      debugPrint("📤 Send OTP API called");
      debugPrint("📱 Phone: $phone");

      final response = await http.post(
        Uri.parse("$baseUrl/user/sendotp"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"phone": phone}),
      );

      debugPrint("✅ Status Code: ${response.statusCode}");
      debugPrint("📦 Response Body: ${response.body}");

      final data = jsonDecode(response.body);
      return data["success"] == true;
    } catch (e) {
      debugPrint("❌ Send OTP Error: $e");
      return false;
    }
  }

  /// 🔐 VERIFY OTP
  static Future<Map<String, dynamic>> verifyOtp(
      String phone, String otp) async {
    try {
      debugPrint("📤 Verify OTP API called");

      final response = await http.post(
        Uri.parse("$baseUrl/user/verifyotp"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "phone": phone,
          "otp": otp,
        }),
      );

      debugPrint("📦 Verify OTP Response: ${response.body}");

      final data = jsonDecode(response.body);

      /// 🔐 SAVE TOKEN IF PRESENT
      if (data["token"] != null) {
        setToken(data["token"]);
      }

      return data;
    } catch (e) {
      debugPrint("❌ Verify OTP Error: $e");
      return {"success": false};
    }
  }

  /// 👤 FETCH USER PROFILE
  static Future<UserProfileResponse> fetchUserProfile() async {
    try {
      debugPrint("➡️ Fetching User Profile...");
      debugPrint("🔐 Token Used: $token");

      final response = await http.get(
        Uri.parse("$baseUrl/user/profile"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      debugPrint("✅ Profile Status: ${response.statusCode}");
      debugPrint("📦 Profile Response: ${response.body}");

      if (response.statusCode == 200) {
        return UserProfileResponse.fromJson(
          jsonDecode(response.body),
        );
      } else {
        throw Exception("Profile fetch failed");
      }
    } catch (e) {
      debugPrint("❌ Fetch Profile Error: $e");
      rethrow;
    }
  }

  static Future<bool> createOrUpdateProfile({
    required String name,
    String? gender,
    String? dob,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/user/profile"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "name": name,
          "gender": gender,
          "dob": dob,
        }),
      );

      debugPrint("📦 Create Profile Response: ${response.body}");

      final data = jsonDecode(response.body);
      return data["success"] == true;
    } catch (e) {
      debugPrint("❌ Create Profile Error: $e");
      return false;
    }
  }

  /// 🗑 DELETE USER ACCOUNT
  static Future<bool> deleteAccount() async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/user/delete"),
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      debugPrint("📦 Delete Account Response: ${response.body}");

      final data = jsonDecode(response.body);
      return data["success"] == true;
    } catch (e) {
      debugPrint("❌ Delete Account Error: $e");
      return false;
    }
  }


}
