import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/Vendor/core/api/api_service.dart';
import 'package:http/http.dart';

class JobsProvider with ChangeNotifier {
  bool isLoading = false;
  List jobs = [];

  Future<void> getAllJobs() async {
    isLoading = true;
    notifyListeners();

    try {
      final res = await ApiService.get("/jobs/getalljobs");

      if (res.statusCode == 200) {
        jobs = jsonDecode(res.body)['data'] ?? [];
      }
    } catch (e) {
      debugPrint("JOBS ERROR ❌ $e");
    }

    isLoading = false;
    notifyListeners();
  }
}
