import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/user_model.dart';
import '../../Model/user_profile_response.dart';

class ProfileProvider extends ChangeNotifier {
  UserModel? user;
  bool loading = false;

  final String baseUrl = "http://localhost:3000";

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("auth_token");
  }

  /// 🔹 FETCH PROFILE
  Future<void> fetchProfile() async {
    try {
      loading = true;
      notifyListeners();

      final token = await _getToken();
      if (token == null) return;

      final response = await http.get(
        Uri.parse("$baseUrl/user/profile"),
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      final data = jsonDecode(response.body);
      final parsed = UserProfileResponse.fromJson(data);

      if (parsed.success) {
        user = parsed.user;
      }
    } catch (e) {
      debugPrint("❌ Fetch profile error: $e");
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  /// 🔹 UPDATE PROFILE
  Future<bool> updateProfile({
    required String name,
    required String gender,
    required String dob,
  }) async {
    try {
      loading = true;
      notifyListeners();

      final token = await _getToken();
      if (token == null) return false;

      final response = await http.put(
        Uri.parse("$baseUrl/user/update-profile"),
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

      final data = jsonDecode(response.body);
      final parsed = UserProfileResponse.fromJson(data);

      if (parsed.success) {
        user = parsed.user; // 🔥 INSTANT UPDATE
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("❌ Update error: $e");
      return false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void clearProfile() {
    user = null;
    notifyListeners();
  }

  Future<bool> deleteAccount() async {
    try {
      loading = true;
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("auth_token");

      if (token == null) {
        debugPrint("❌ TOKEN NULL - deleteAccount");
        return false;
      }

      final response = await http.delete(
        Uri.parse("$baseUrl/user/delete-account"),
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      debugPrint("🗑 DELETE RESPONSE: ${response.body}");
      debugPrint("📌 STATUS CODE: ${response.statusCode}");

      final data = jsonDecode(response.body);

      if (data["success"] == true) {
        /// 🔥 TOKEN REMOVE
        await prefs.remove("auth_token");

        /// 🔥 CLEAR USER DATA
        user = null;
        notifyListeners();
        return true;
      }

      return false;
    } catch (e) {
      debugPrint("❌ Delete account error: $e");
      return false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }


}
