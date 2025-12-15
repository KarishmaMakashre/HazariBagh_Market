import 'package:flutter/material.dart';
import '../../../widgets/top_header.dart';

class JobApplyFormScreen extends StatelessWidget {
  const JobApplyFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final width = mq.width;
    final height = mq.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 🔵 TOP HEADER (without padding)
            const TopHeader(),

            /// ⭐ PADDING HERE (entire content except TopHeader)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: height * 0.015),

                  /// 🔴 BACK & TITLE
                  Row(
                    children: [
                      Icon(Icons.arrow_back, color: Colors.red, size: width * 0.055),
                      SizedBox(width: width * 0.02),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          "Apply For Job",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: width * 0.038,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),

                  SizedBox(height: height * 0.012),

                  /// SUBTITLE
                  Text(
                    "Applying For Full Stack Developer (Tech Solutions Pvt Ltd)",
                    style: TextStyle(
                      fontSize: width * 0.032,
                      color: Colors.grey[700],
                    ),
                  ),

                  SizedBox(height: height * 0.02),

                  /// FORM CARD
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(width * 0.03),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(width * 0.04),
                      child: Column(
                        children: [

                          _buildTextField(width, "Full Name", "Enter your full name"),
                          _buildTextField(width, "Phone Number", "+91-1234567890"),
                          _buildTextField(width, "Email", "your.email@example.com"),
                          _buildTextField(width, "Total Exp.", "e.g. 2 years"),

                          _buildMultiLineField(
                            width,
                            "Cover Letter / Resume",
                            "Why are you a good fit for this position?",
                          ),

                          SizedBox(height: height * 0.02),

                          /// SUBMIT BUTTON
                          SizedBox(
                            width: double.infinity,
                            height: height * 0.055,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(width * 0.025),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                "Submit Application",
                                style: TextStyle(
                                  fontSize: width * 0.04,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.03),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// NORMAL TEXT FIELD
  Widget _buildTextField(double width, String label, String hint) {
    return Padding(
      padding: EdgeInsets.only(bottom: width * 0.035),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: TextStyle(fontSize: width * 0.035),
          hintStyle: TextStyle(fontSize: width * 0.034),
          contentPadding: EdgeInsets.symmetric(
            horizontal: width * 0.035,
            vertical: width * 0.03,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width * 0.025),
          ),
        ),
      ),
    );
  }

  /// MULTILINE FIELD
  Widget _buildMultiLineField(double width, String label, String hint) {
    return Padding(
      padding: EdgeInsets.only(bottom: width * 0.035),
      child: TextField(
        maxLines: 4,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: TextStyle(fontSize: width * 0.035),
          hintStyle: TextStyle(fontSize: width * 0.034),
          contentPadding: EdgeInsets.all(width * 0.035),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width * 0.025),
          ),
        ),
      ),
    );
  }
}
