import 'package:flutter/material.dart';
import '../../../colors/AppColors.dart';
// Assuming the TopHeader widget is located here:
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

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      // Removed AppBar
      body: Column(
        children: [
          // 🔑 Added TopHeader here
          const TopHeader(),

          // 🔑 Custom Header for Back Button and Title (Replaces AppBar)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: 12),
            child: Row(
              children: [
                // 🔙 BACK BUTTON
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: AppColors.propertyAccent),
                  onPressed: () => Navigator.pop(context),
                  // Reduce padding to match the image's tight alignment
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                SizedBox(width: w * 0.02),
                // 💬 TITLE
                const Text(
                  "Enquiry Now",
                  style: TextStyle(
                    color: AppColors.propertyAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 18, // Adjust size to look like a title
                  ),
                ),
              ],
            ),
          ),

          // 🔑 Form Content now in an Expanded SingleChildScrollView
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05, bottom: w * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- 👤 YOUR NAME FIELD ---
                  _buildInputField(
                    title: "Your Name",
                    hintText: "Enter your name..........",
                    keyboardType: TextInputType.name,
                    maxLines: 1,
                  ),
                  SizedBox(height: w * 0.05),

                  // --- 📞 PHONE NUMBER FIELD ---
                  _buildInputField(
                    title: "Phone Number",
                    hintText: "+91-1223445666",
                    keyboardType: TextInputType.phone,
                    maxLines: 1,
                  ),
                  SizedBox(height: w * 0.05),

                  // --- 💬 MESSAGE FIELD ---
                  _buildInputField(
                    title: "Message",
                    hintText: "I'm interested in this property..........",
                    keyboardType: TextInputType.multiline,
                    maxLines: 6, // Larger text area
                  ),
                  SizedBox(height: w * 0.05),

                  // --- ℹ️ PROPERTY CONTEXT BOX ---
                  _buildPropertyContextBox(w),
                  SizedBox(height: w * 0.1),

                  // --- 🚀 SEND ENQUIRE BUTTON ---
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.propertyAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        // TODO: Implement submission logic (API call, validation)
                        print("Enquiry Sent for $propertyTitle");
                      },
                      child: const Text(
                        "Send Enquire",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
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

  /// Helper method for building text input fields
  Widget _buildInputField({
    required String title,
    required String hintText,
    required TextInputType keyboardType,
    required int maxLines,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: AppColors.textGrey, fontStyle: FontStyle.italic),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
            ),
            filled: true,
            fillColor: AppColors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.border, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.border, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primary, width: 2.0),
            ),
          ),
        ),
      ],
    );
  }

  /// Helper method for the property context box
  Widget _buildPropertyContextBox(double w) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Property: $propertyTitle",
            style: TextStyle(
              fontSize: w * 0.04,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Contact: $contactName",
            style: TextStyle(
              fontSize: w * 0.035,
              color: AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }
}