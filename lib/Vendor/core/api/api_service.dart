import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://api.hazaribagmarket.in";
  static const String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5N2RhMzhlMzNmMDI1ZDkxZTAxNjhjYiIsInJvbGUiOiJ2ZW5kb3IiLCJpYXQiOjE3Njk4NDIxNTEsImV4cCI6MTc3NTg5MDE1MX0.4mHdgz0TvDB89y-cuRYjUDiKjEVZG8CdT7ePMFCf510"; // 🔑 same token everywhere

  /// ---------- GET ----------
  static Future<http.Response> get(String endpoint) async {
    final url = Uri.parse("$baseUrl/$endpoint");

    return await http.get(
      url,
      headers: {
        "Authorization": token,
        "Content-Type": "application/json",
      },
    );
  }

  /// ---------- POST ----------
  static Future<http.Response> post(
      String endpoint,
      Map<String, dynamic> body,
      ) async {
    final url = Uri.parse("$baseUrl/$endpoint");

    return await http.post(
      url,
      headers: {
        "Authorization": token,
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );
  }

  /// ---------- MULTIPART ----------
  static Future<http.Response> multipart({
    required String endpoint,
    required Map<String, String> fields,
    required Map<String, File> files,
    String method = "POST",
  }) async {
    final uri = Uri.parse("$baseUrl/$endpoint");
    final request = http.MultipartRequest(method, uri);

    request.headers.addAll({
      "Authorization": token,
    });

    request.fields.addAll(fields);

    for (var file in files.entries) {
      request.files.add(
        await http.MultipartFile.fromPath(
          file.key,
          file.value.path,
        ),
      );
    }

    final response = await request.send();
    return http.Response.fromStream(response);
  }
}
