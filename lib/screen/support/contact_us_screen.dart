import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(w * 0.04),
        child: Column(
          children: [
            contactCard(
              context: context,
              icon: Icons.call,
              color: Colors.blue.shade700,
              title: "Call Us",
              subtitle: "Mon-Sun: 9:00 AM - 9:00 PM\n+91-9888999999",
              actionText: "+91-9888999999",
              onTap: () => launchUrl(Uri.parse("tel:+919888999999")),
            ),

            SizedBox(height: h * 0.02),

            contactCard(
              context: context,
              icon: Icons.wallet_giftcard,
              color: Colors.green,
              title: "WhatsApp",
              subtitle: "Quick Support Via WhatsApp",
              actionText: "Chat on WhatsApp",
              onTap: () => launchUrl(
                  Uri.parse("https://wa.me/919888999999?text=Hello")),
            ),

            SizedBox(height: h * 0.02),

            contactCard(
              context: context,
              icon: Icons.email,
              color: Colors.red,
              title: "Email Us",
              subtitle: "We'll Respond Within 24 Hours",
              actionText: "support@hazaribagh.market",
              onTap: () => launchUrl(
                Uri.parse("mailto:support@hazaribagh.market"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// CONTACT CARD WIDGET
  Widget contactCard({
    required BuildContext context,
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required String actionText,
    required VoidCallback onTap,
  }) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(w * 0.03),

      child: Container(
        padding: EdgeInsets.all(w * 0.04),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(w * 0.03),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              spreadRadius: 1,
            ),
          ],
        ),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ICON CIRCLE
            Container(
              padding: EdgeInsets.all(w * 0.03),
              decoration: BoxDecoration(
                color: color.withOpacity(0.10),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: w * 0.08),
            ),

            SizedBox(width: w * 0.04),

            /// TEXT DETAILS
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                        fontSize: w * 0.045,
                        fontWeight: FontWeight.bold,
                      )),

                  SizedBox(height: h * 0.006),

                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: w * 0.035,
                      height: 1.4,
                    ),
                  ),

                  SizedBox(height: h * 0.006),

                  Text(
                    actionText,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: w * 0.038,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
