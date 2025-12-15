import 'package:flutter/material.dart';
import '../../../widgets/top_header.dart';
import 'job_apply_form_screen.dart';

class JobDetailsScreen extends StatelessWidget {
  const JobDetailsScreen({super.key});

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

            /// 🔵 Custom Top Header
            const TopHeader(),

            SizedBox(height: height * 0.015),

            /// 🔴 BACK BUTTON
            Padding(
              padding: EdgeInsets.all(width * 0.03),
              child: Row(
                children: [
                  Icon(Icons.arrow_back, color: Colors.red, size: width * 0.055),
                  SizedBox(width: width * 0.02),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Back",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: width * 0.038,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// 🏢 JOB CARD
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(width * 0.04),
              ),
              child: Padding(
                padding: EdgeInsets.all(width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// COMPANY + LOGO
                    Row(
                      children: [
                        CircleAvatar(
                          radius: width * 0.08,
                          backgroundColor: Colors.grey.shade300,
                        ),
                        SizedBox(width: width * 0.03),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tech Solutions Pvt Ltd",
                              style: TextStyle(
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: height * 0.005),
                            Chip(
                              label: Text(
                                "IT & Software",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width * 0.032),
                              ),
                              backgroundColor: Colors.orange,
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: height * 0.015),

                    /// 📍 LOCATION
                    Row(
                      children: [
                        Icon(Icons.location_on, size: width * 0.044),
                        SizedBox(width: width * 0.02),
                        Text(
                          "Indore-Hazaribagh (Work From Office)",
                          style: TextStyle(fontSize: width * 0.034),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.008),

                    /// 💰 SALARY
                    Row(
                      children: [
                        Icon(Icons.currency_rupee, size: width * 0.044),
                        SizedBox(width: width * 0.02),
                        Text(
                          "Salary: 4–6 LPA",
                          style: TextStyle(fontSize: width * 0.034),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.008),

                    /// EXPERIENCE & POSTED
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.work, size: width * 0.044),
                            SizedBox(width: width * 0.02),
                            Text(
                              "Experience: 2–4 Years",
                              style: TextStyle(fontSize: width * 0.034),
                            ),
                          ],
                        ),
                        Text(
                          "Posted: 2 days ago",
                          style: TextStyle(fontSize: width * 0.032),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: height * 0.02),

            /// DESCRIPTION + SKILLS
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(width * 0.05),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style: TextStyle(
                      fontSize: width * 0.042,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: height * 0.008),
                  Text(
                    "Looking for an experienced full stack developer.",
                    style: TextStyle(fontSize: width * 0.034),
                  ),

                  SizedBox(height: height * 0.02),

                  Text(
                    "Required Skills",
                    style: TextStyle(
                      fontSize: width * 0.042,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: height * 0.008),
                  Text(
                    "React, Node.js, TypeScript and MongoDB.",
                    style: TextStyle(fontSize: width * 0.034),
                  ),
                ],
              ),
            ),

            SizedBox(height: height * 0.02),

            /// 📞 CONTACT INFO
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(width * 0.04),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width * 0.03),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Contact Information",
                    style: TextStyle(
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: height * 0.01),

                  Row(
                    children: [
                      Icon(Icons.phone, size: width * 0.045),
                      SizedBox(width: width * 0.02),
                      Text("+91-4321098765", style: TextStyle(fontSize: width * 0.034)),
                    ],
                  ),
                  SizedBox(height: height * 0.008),

                  Row(
                    children: [
                      Icon(Icons.email, size: width * 0.045),
                      SizedBox(width: width * 0.02),
                      Text("careers@techsolutions.com", style: TextStyle(fontSize: width * 0.034)),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: height * 0.03),

            /// APPLY + CALL BUTTONS
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: height * 0.055,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => JobApplyFormScreen()),
                          );
                        },
                        child: Text(
                          "Apply Now",
                          style: TextStyle(
                              fontSize: width * 0.038, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: width * 0.03),
                  Expanded(
                    child: SizedBox(
                      height: height * 0.055,
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Text(
                          "Call Employer",
                          style: TextStyle(fontSize: width * 0.038),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: height * 0.04),
          ],
        ),
      ),
    );
  }
}
