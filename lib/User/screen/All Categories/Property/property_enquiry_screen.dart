import 'package:flutter/material.dart';

import '../../../../Model/home_model.dart';
import '../../../../colors/AppColors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../widgets/app_back_button.dart';
import '../../../widgets/top_header.dart';

class PropertyEnquiryScreen extends StatelessWidget {
  final String propertyTitle;
  final String contactName;

  const PropertyEnquiryScreen({
    super.key,
    required this.propertyTitle,
    required this.contactName,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bgColor = isDark ? const Color(0xFF0F172A) : AppColors.bgLight;
    final cardColor = isDark ? const Color(0xFF1E293B) : AppColors.white;
    final textColor = isDark ? Colors.white : AppColors.textDark;
    final subTextColor =
    isDark ? Colors.grey.shade400 : AppColors.textLight;
    final borderColor =
    isDark ? Colors.grey.shade600 : AppColors.border;

    return Scaffold(
      backgroundColor: Color(0xffF6F6F6FF),
      body: Column(
        children: [
          TopHeader(),

          SizedBox(height: w * 0.05),

          /// 🔙 Back Bar (ACCENT COLOR)
          AppBackButton(
            width: w,
            color: AppColors.primary ,
            text: loc.back,
          ),
          SizedBox(height: w * 0.05),

          /// 📄 FORM
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: w * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInputField(
                    context: context,
                    title: loc.getByKey('full Name'),
                    hintText: loc.getByKey('full Name Hint'),
                    keyboardType: TextInputType.name,
                    maxLines: 1,
                    cardColor: cardColor,
                    textColor: textColor,
                    borderColor: borderColor,
                  ),
                  SizedBox(height: w * 0.05),

                  _buildInputField(
                    context: context,
                    title: loc.getByKey('phone Number'),
                    hintText: '+91-XXXXXXXXXX',
                    keyboardType: TextInputType.phone,
                    maxLines: 1,
                    cardColor: cardColor,
                    textColor: textColor,
                    borderColor: borderColor,
                  ),
                  SizedBox(height: w * 0.05),

                  _buildInputField(
                    context: context,
                    title: loc.description,
                    hintText: loc.descriptionHint,
                    keyboardType: TextInputType.multiline,
                    maxLines: 6,
                    cardColor: cardColor,
                    textColor: textColor,
                    borderColor: borderColor,
                  ),
                  SizedBox(height: w * 0.05),

                  _buildPropertyContextBox(
                    context,
                    w,
                    cardColor,
                    textColor,
                    subTextColor,
                  ),
                  SizedBox(height: w * 0.012),

                  /// 🚀 SEND BUTTON (ACCENT COLOR)
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        debugPrint(
                          "Enquiry Sent for $propertyTitle to $contactName",
                        );
                      },
                      child: Text(
                        loc.getByKey('enquireNow'),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 INPUT FIELD
  Widget _buildInputField({
    required BuildContext context,
    required String title,
    required String hintText,
    required TextInputType keyboardType,
    required int maxLines,
    required Color cardColor,
    required Color textColor,
    required Color borderColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: textColor,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: TextStyle(color: textColor),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontStyle: FontStyle.italic,
            ),
            filled: true,
            fillColor: cardColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.propertyAccent,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// 🏠 PROPERTY INFO
  Widget _buildPropertyContextBox(
      BuildContext context,
      double w,
      Color cardColor,
      Color textColor,
      Color subTextColor,
      ) {
    final loc = AppLocalizations.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${loc.propertyListing}: $propertyTitle",
            style: TextStyle(
              fontSize: w * 0.04,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "${loc.contactInformation}: $contactName",
            style: TextStyle(
              fontSize: w * 0.035,
              color: subTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
