class ApiConstants {
  static const String baseUrl = "https://api.hazaribagmarket.in";

  static const String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5N2RhMzhlMzNmMDI1ZDkxZTAxNjhjYiIsInJvbGUiOiJ2ZW5kb3IiLCJpYXQiOjE3Njk4NDIxNTEsImV4cCI6MTc3NTg5MDE1MX0.4mHdgz0TvDB89y-cuRYjUDiKjEVZG8CdT7ePMFCf510";

  static Map<String, String> get authHeader => {
    "Authorization": "Bearer $token",
  };
}
