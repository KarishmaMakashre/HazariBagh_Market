import 'package:flutter/material.dart';
import '../../../../Model/home_model.dart';
import '../../../../colors/AppColors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../widgets/app_back_button.dart';
import '../../../widgets/top_header.dart';

class JobApplyFormScreen extends StatelessWidget {
  const JobApplyFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final w = mq.width;
    final h = mq.height;
    final loc = AppLocalizations.of(context)!;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isDark ? const Color(0xFF0F172A) : const Color(0xFFF5F7FA);
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final hintColor =
    isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔝 HEADER
            const TopHeader(),

            SizedBox(height: h * 0.01),

            /// 🔙 BACK BUTTON
            AppBackButton(
              width: w,
              color: AppColors.primary,
              text: loc.back,
            ),

            SizedBox(height: h * 0.01),

            /// 📄 FORM CARD
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.05),
              child: Container(
                padding: EdgeInsets.all(w * 0.05),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _textField(
                      w,
                      textColor,
                      hintColor,
                      "Full Name",
                      "Enter your name",
                    ),
                    _textField(
                      w,
                      textColor,
                      hintColor,
                      "Phone Number",
                      "+91-1234567890",
                      keyboardType: TextInputType.phone,
                    ),
                    _textField(
                      w,
                      textColor,
                      hintColor,
                      "Email",
                      "your.email@example.com",
                      keyboardType: TextInputType.emailAddress,
                    ),
                    _textField(
                      w,
                      textColor,
                      hintColor,
                      "Total Experience",
                      "e.g. 2 years",
                      keyboardType: TextInputType.number,
                    ),
                    _multiLineField(
                      w,
                      textColor,
                      hintColor,
                      "Cover Letter / Resume",
                      "Why are you a good fit for this position?",
                    ),

                    SizedBox(height: h * 0.03),

                    /// 🚀 SUBMIT BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          debugPrint("Submit Application Clicked");
                        },
                        child: const Text(
                          "Submit Application",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: h * 0.05),
          ],
        ),
      ),
    );
  }

  /// 🔹 SINGLE LINE FIELD
  Widget _textField(
      double w,
      Color textColor,
      Color hintColor,
      String label,
      String hint, {
        TextInputType keyboardType = TextInputType.text,
      }) {
    return Padding(
      padding: EdgeInsets.only(bottom: w * 0.04),
      child: TextField(
        keyboardType: keyboardType,
        style: TextStyle(color: textColor),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: TextStyle(color: hintColor),
          hintStyle: TextStyle(color: hintColor),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: hintColor.withOpacity(0.4)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColors.primary,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  /// 🔹 MULTI LINE FIELD
  Widget _multiLineField(
      double w,
      Color textColor,
      Color hintColor,
      String label,
      String hint,
      ) {
    return Padding(
      padding: EdgeInsets.only(bottom: w * 0.04),
      child: TextField(
        maxLines: 4,
        style: TextStyle(color: textColor),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: TextStyle(color: hintColor),
          hintStyle: TextStyle(color: hintColor),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: hintColor.withOpacity(0.4)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColors.primary,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
