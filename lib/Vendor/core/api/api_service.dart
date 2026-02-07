import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://api.hazaribagmarket.in";

  static const String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5N2RhMzhlMzNmMDI1ZDkxZTAxNjhjYiIsInJvbGUiOiJ2ZW5kb3IiLCJpYXQiOjE3Njk4NDIxNTEsImV4cCI6MTc3NTg5MDE1MX0.4mHdgz0TvDB89y-cuRYjUDiKjEVZG8CdT7ePMFCf510";

  /// ---------- GET ----------
  static Future<http.Response> get(String endpoint) async {
    final url = Uri.parse("$baseUrl/$endpoint");
    return await http.get(
      url,
      headers: {
        "Authorization": "Bearer $token", // ✅ FIX
        "Content-Type": "application/json",
      },
    );
  }

  /// ---------- MULTIPART ----------
  static Future<http.Response> multipart({
    required String endpoint,
    required Map<String, String> fields,
    required Map<String, File> files,
  }) async {
    final uri = Uri.parse("$baseUrl/$endpoint");
    final request = http.MultipartRequest("POST", uri);

    request.headers.addAll({
      "Authorization": "Bearer $token", // ✅ FIX
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