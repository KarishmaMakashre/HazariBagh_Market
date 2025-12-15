import 'package:flutter/material.dart';
// Assuming TopHeader widget is located here:
import '../../../widgets/top_header.dart';
import 'package:hazari_bagh_market/screen/All%20Categories/Property/property_enquiry_screen.dart';
import 'package:provider/provider.dart';
import '../../../colors/AppColors.dart';
import '../../../provider/property_provider.dart';
import '../../../Model/property_model.dart';

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

      // Removed AppBar
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔑 ADDED TopHeader
          const TopHeader(),

          /// 🔑 CUSTOM HEADER (Replaces AppBar Title and Back Button)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: 8),
            child: Row(
              children: [
                // Back Button
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: AppColors.propertyAccent),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                SizedBox(width: w * 0.02),
                // Title
                const Text(
                  "View Details",
                  style: TextStyle(
                      color: AppColors.propertyAccent,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),

          /// 🔑 EXPANDED BODY CONTENT
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(w * 0.04).copyWith(top: 0), // Adjust top padding after custom header
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🖼 PROPERTY IMAGE
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(
                      property.image,
                      // Responsive size using MediaQuery (w)
                      height: w * 0.55,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// 🏷 TAGS
                  Row(
                    children: [
                      // 🎨 Using AppColors.warning for the type tag (Orange)
                      _tag(property.type, AppColors.warning),
                      const SizedBox(width: 8),
                      // 🎨 Using AppColors.success for the Verified tag (Green)
                      _tag("Verified", AppColors.success),
                      const Spacer(),
                      Text(
                        property.price,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          // 🎨 Using AppColors.success
                          color: AppColors.success,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  /// 📍 LOCATION & DETAILS
                  _infoRow(Icons.location_on, "Civil Lines, Hazaribagh"),
                  _infoRow(Icons.square_foot, "600 sq ft"),
                  _infoRow(Icons.bed, "1 Bedrooms, 1 Bathrooms"),

                  const SizedBox(height: 12),

                  /// 📝 DESCRIPTION
                  const Text(
                    "Description",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Compact 1BHK Flat in central location, perfect for working professionals.",
                    style: TextStyle(fontSize: 12),
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
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        const Text("Name\nCity Brokers",
                            style: TextStyle(fontSize: 12)),
                        const SizedBox(height: 6),
                        const Text("Type\nBrokers",
                            style: TextStyle(fontSize: 12)),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            // 🎨 Using AppColors.success for phone icon
                            const Icon(Icons.phone,
                                size: 16, color: AppColors.success),
                            const SizedBox(width: 6),
                            const Text("+91 4321098765",
                                style: TextStyle(fontSize: 12)),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            // 🎨 Using AppColors.primary (Main Blue) for email icon
                            const Icon(Icons.email,
                                size: 16, color: AppColors.primary),
                            const SizedBox(width: 6),
                            const Text("citybrokers@gmail.com",
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
                      // 🎨 Using AppColors.yellowNote
                      color: AppColors.yellowNote,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "Verify Before Payment: Always verify property documents, owner credentials, and visit the property before making any payment.",
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
                          onPressed: () {
                            // TODO: Implement actual phone call logic here
                          },
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
                            "Enquire now",
                            style: TextStyle(color: AppColors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🏷 TAG WIDGET
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
            color: color, fontSize: 11, fontWeight: FontWeight.w600),
      ),
    );
  }

  /// ℹ️ INFO ROW
  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          // 🎨 Using AppColors.textGrey for info icons
          Icon(icon, size: 16, color: AppColors.textGrey),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}