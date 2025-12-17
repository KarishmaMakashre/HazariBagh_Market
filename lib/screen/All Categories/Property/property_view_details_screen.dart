import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/top_header.dart';
import '../../../colors/AppColors.dart';
import '../../../provider/property_provider.dart';
import '../../../Model/property_model.dart';
import 'property_enquiry_screen.dart';

class PropertyDetailsScreen extends StatelessWidget {
  const PropertyDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final propertyProvider = context.watch<PropertyProvider>();
    final PropertyModel? property = propertyProvider.selectedProperty;

    if (property == null) {
      return const Scaffold(
        body: Center(child: Text("No Property Selected")),
      );
    }

    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔝 TOP HEADER
          const TopHeader(),

          /// 🔙 BACK + TITLE
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: 10),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => Navigator.pop(context),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.arrow_back,
                    color: AppColors.propertyAccent,
                  ),
                  SizedBox(width: w * 0.02),
                  const Text(
                    "Back",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.propertyAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),


          /// 🔽 BODY
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child: Column(
                children: [
                  /// ✅ FULL CARD CLICKABLE
                  InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      debugPrint("Property card tapped");
                    },
                    child: Container(
                      padding: EdgeInsets.all(w * 0.04),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// 🖼 IMAGE
                          ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image.asset(
                              property.image,
                              height: w * 0.55,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),

                          const SizedBox(height: 12),

                          /// 🏷 TAGS + PRICE
                          Row(
                            children: [
                              _tag(property.type, AppColors.warning),
                              const SizedBox(width: 8),
                              _tag("Verified", AppColors.success),
                              const Spacer(),
                              Text(
                                property.price,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.success,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          /// 📍 INFO
                          _infoRow(Icons.location_on, "Civil Lines, Hazaribagh"),
                          _infoRow(Icons.square_foot, "600 sq ft"),
                          _infoRow(Icons.bed, "1 Bedroom, 1 Bathroom"),

                          const SizedBox(height: 12),

                          /// 📝 DESCRIPTION
                          const Text(
                            "Description",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "Compact 1BHK Flat in central location, perfect for working professionals.",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  /// 📞 CONTACT INFO
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 4),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Contact Information",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text("Name\nCity Brokers",
                            style: TextStyle(fontSize: 12)),
                        const SizedBox(height: 6),
                        const Text("Type\nBroker",
                            style: TextStyle(fontSize: 12)),
                        const SizedBox(height: 6),
                        Row(
                          children: const [
                            Icon(Icons.phone,
                                size: 16, color: AppColors.success),
                            SizedBox(width: 6),
                            Text("+91 4321098765",
                                style: TextStyle(fontSize: 12)),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: const [
                            Icon(Icons.email,
                                size: 16, color: AppColors.primary),
                            SizedBox(width: 6),
                            Text("citybrokers@gmail.com",
                                style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// ⚠️ VERIFY NOTE
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.yellowNote,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "Verify property documents, owner credentials and visit the property before making any payment.",
                      style: TextStyle(fontSize: 11),
                    ),
                  ),

                  const SizedBox(height: 14),

                  /// 📲 ACTION BUTTONS
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.success,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () {},
                          child: const Text("Call Now"),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.propertyAccent,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PropertyEnquiryScreen(
                                  propertyTitle: property.title,
                                  contactName: property.contactName,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            "Enquire Now",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🏷 TAG
  Widget _tag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// ℹ️ INFO ROW
  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.textGrey),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
