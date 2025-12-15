import 'package:flutter/material.dart';
import '../../../Model/service_model.dart';
import '../../../widgets/top_header.dart';
import '../../../colors/AppColors.dart';
import 'book_appointment_step1.dart';

class ServiceDetailScreen extends StatelessWidget {
  final ServiceModel service;

  const ServiceDetailScreen({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.black.withOpacity(0.25), // dim background
      body: SafeArea(
        child: Column(
          children: [

            /// 🔵 TOP HEADER
            const TopHeader(),

            SizedBox(height: h * 0.015),

            /// 🔳 CENTER CARD
            Expanded(
              child: Center(
                child: Container(
                  width: w * 0.9,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),

                    /// 🔥 CARD SHADOW
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: 15,
                        spreadRadius: 2,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        /// 🔝 TITLE + CLOSE
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(width: 24),
                              Text(
                                service.title.toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: w * 0.042,
                                  color: AppColors.textDark,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Icon(
                                  Icons.close,
                                  color: AppColors.textDark,
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// 🖼 IMAGE
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              service.image,
                              height: h * 0.25,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        /// 📄 CONTENT
                        Padding(
                          padding: EdgeInsets.all(w * 0.04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              /// DESCRIPTION
                              Text(
                                "Professional grooming services for men",
                                style: TextStyle(
                                  fontSize: w * 0.038,
                                  color: AppColors.textGrey,
                                ),
                              ),

                              SizedBox(height: h * 0.02),

                              /// SERVICES OFFERED
                              Text(
                                "Services Offered",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textDark,
                                ),
                              ),

                              SizedBox(height: h * 0.015),

                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: service.servicesOffered.length,
                                gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 3.8,
                                ),
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: AppColors.bgLight,
                                      borderRadius:
                                      BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.circle,
                                          size: 8,
                                          color: AppColors.primary,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          service.servicesOffered[index],
                                          style: TextStyle(
                                            fontSize: w * 0.033,
                                            color: AppColors.textDark,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),

                              SizedBox(height: h * 0.02),

                              /// PRICE
                              Text(
                                "Pricing",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textDark,
                                ),
                              ),

                              const SizedBox(height: 6),

                              Text(
                                service.price,
                                style: TextStyle(
                                  color: AppColors.textGrey,
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// 🔘 BUTTON
                        Padding(
                          padding: EdgeInsets.all(w * 0.04),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BookAppointmentStep1(
                                      serviceTitle: service.title,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                service.buttonText,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
