// lib/utils/app_colors.dart (Suggested Location)

import 'package:flutter/material.dart';

class AppColors {
  // 🔵 PRIMARY BRAND COLORS
  static const Color primary = Color(0xFF3670A3);     // Main Blue (Used for Back button)
  static const Color primaryDark = Color(0xFF2E78B7);
  static const Color primaryLight = Color(0xFF6FA6D6);

  // 🟤 PROPERTY THEME COLOR (The existing brown color from the property screen)
  static const Color propertyAccent = Color(0xFFB88A64);

  // ⚪ BASIC COLORS
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  // 📝 TEXT COLORS
  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textLight = Color(0xFF6F6F6F);
  static const Color textGrey = Color(0xFF9E9E9E);

  // 🔵 EXTRA COLORS FOR LOGIN SCREEN
  static const Color greyText = Color(0xFFB5B5B5);        // Input hint text
  static const Color inputBackground = Colors.white;      // Mobile box bg
  static const Color otpBorder = Colors.white;            // OTP button border
  static const Color linkBlue = Color(0xFF6FA6D6);        // Policy & Links

  // 🔘 BACKGROUND COLORS
  static const Color bgLight = Color(0xFFF7F7F7);
  static const Color bgDark = Color(0xFF212121);
  static const Color bgScreen = Colors.grey; // Using a general name for the grey background

  // 🔲 OVERLAY COLOR (For login background dim effect)
  static Color darkOverlay = Colors.black.withOpacity(0.45);

  // 🟩 SUCCESS / ERROR / WARNING
  static const Color success = Color(0xFF4CAF50); // Green for verified/owner/sale
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFA000);
  static const Color yellowNote = Color(0xFFFFF3CD); // The light yellow warning box color

  // 🔳 BORDER COLOR
  static const Color border = Color(0xFFE0E0E0);

  // 🌑 SHADOW COLOR
  static Color shadow = Colors.black.withOpacity(0.25);

  static const Color fieldBg = Color(0xFFF1F3F6);

}