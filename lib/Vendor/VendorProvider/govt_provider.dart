import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../vendor_screens/models/govt_model.dart';
import '../vendor_screens/utils/api_constants.dart';

class GovtProvider with ChangeNotifier {
  bool isLoading = false;
  List<GovtModel> services = [];

  Map<String, String> get _headers => ApiConstants.authHeader;

  // ================= CREATE GOVERNMENT SERVICE =================
  Future<bool> createGovtService({
    required Map<String, String> fields,
    required List<File> images,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      final request = http.MultipartRequest(
        "POST",
        Uri.parse("${ApiConstants.baseUrl}/service/create"),
      );

      // Add headers (remove content-type for multipart)
      final headers = Map<String, String>.from(_headers);
      headers.remove('Content-Type'); // multipart handles this automatically
      request.headers.addAll(headers);

      // Add fields
      request.fields.addAll(fields);

      // Convert requiredDocuments to JSON string if needed
      if (fields.containsKey('requiredDocuments')) {
        request.fields['requiredDocuments'] =
            jsonEncode([fields['requiredDocuments']]);
      }

      // Add images
      for (final img in images) {
        request.files.add(await http.MultipartFile.fromPath(
          "images",
          img.path,
        ));
      }

      final response = await request.send();
      final body = await response.stream.bytesToString();
      debugPrint("🔍 Service create response: $body");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = jsonDecode(body);
        final service = GovtModel.fromJson(decoded['service']);
        services.insert(0, service);

        debugPrint("✅ Government service created successfully");
        return true;
      } else {
        debugPrint("❌ Service create failed: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      debugPrint("🔥 Govt service exception: $e");
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ================= FETCH ALL GOVERNMENT SERVICES =================
  Future<void> fetchGovtServices() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse("${ApiConstants.baseUrl}/service/getall"),
        headers: _headers,
      );

      debugPrint("🔍 Fetch Govt Services response: ${response.body}");

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        if (decoded['success'] == true) {
          final List<dynamic> data = decoded['getAll'];
          services = data.map((e) => GovtModel.fromJson(e)).toList();
          debugPrint("✅ Services fetched successfully: ${services.length}");
        } else {
          debugPrint("❌ Failed to fetch services: ${decoded['message']}");
        }
      } else {
        debugPrint("❌ Failed to fetch services: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("🔥 Exception fetching services: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
