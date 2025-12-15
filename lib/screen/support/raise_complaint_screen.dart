import 'package:flutter/material.dart';
import '../../colors/AppColors.dart';

class RaiseComplaintScreen extends StatelessWidget {
  const RaiseComplaintScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Scaffold(
      backgroundColor: AppColors.bgLight,

      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: w * 0.90,                       // Responsive width
            padding: EdgeInsets.all(w * 0.04),    // Responsive padding
            margin: EdgeInsets.only(top: h * 0.02),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(w * 0.03),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  spreadRadius: 1,
                  blurRadius: 8,
                ),
              ],
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  "Raise a Complaint/ Request Refund",
                  style: TextStyle(
                      fontSize: w * 0.045,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark),
                ),
                SizedBox(height: h * 0.015),

                // SUBJECT
                Text(
                  "Subject",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: w * 0.040,
                      color: AppColors.textDark),
                ),
                SizedBox(height: h * 0.008),

                TextField(
                  decoration: InputDecoration(
                    hintText: "Brief subject of your complaint",
                    hintStyle: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: w * 0.035,
                    ),
                    filled: true,
                    fillColor: AppColors.white,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: w * 0.03, vertical: h * 0.012),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(w * 0.02),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                  ),
                ),

                SizedBox(height: h * 0.015),

                // ORDER NUMBER
                Text(
                  "Order Number (Optional)",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: w * 0.040,
                      color: AppColors.textDark),
                ),
                SizedBox(height: h * 0.008),

                TextField(
                  decoration: InputDecoration(
                    hintText: "Enter order number if applicable",
                    hintStyle: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: w * 0.035,
                    ),
                    filled: true,
                    fillColor: AppColors.white,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: w * 0.03, vertical: h * 0.012),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(w * 0.02),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                  ),
                ),

                SizedBox(height: h * 0.015),

                // DESCRIPTION
                Text(
                  "Description",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: w * 0.040,
                      color: AppColors.textDark),
                ),
                SizedBox(height: h * 0.008),

                TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Describe your issue in details...............",
                    hintStyle: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: w * 0.035,
                    ),
                    filled: true,
                    fillColor: AppColors.white,
                    contentPadding: EdgeInsets.all(w * 0.03),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(w * 0.02),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                  ),
                ),

                SizedBox(height: h * 0.02),

                // SUBMIT BUTTON
                SizedBox(
                  width: double.infinity,
                  height: h * 0.055,            // Responsive button height
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(w * 0.02),
                      ),
                    ),
                    child: Text(
                      "Submit Complaint",
                      style: TextStyle(
                        fontSize: w * 0.040,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: h * 0.012),

                Center(
                  child: Text(
                    "Our team will respond within 24 hours.",
                    style: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: w * 0.035,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
