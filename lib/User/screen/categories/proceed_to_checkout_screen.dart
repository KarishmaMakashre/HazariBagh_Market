import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hazari_bagh_market/User/screen/categories/payment_method_screen.dart';
import '../../../colors/AppColors.dart';
import '../../../l10n/app_localizations.dart';
import '../../widgets/app_back_button.dart';
import '../../widgets/top_header.dart';

class ProceedToCheckoutScreen extends StatefulWidget {
  const ProceedToCheckoutScreen({super.key});

  @override
  State<ProceedToCheckoutScreen> createState() =>
      _ProceedToCheckoutScreenState();
}

class _ProceedToCheckoutScreenState extends State<ProceedToCheckoutScreen> {
  bool isHomeDelivery = true;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final w = mq.width;
    final h = mq.height;
    final loc = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔝 TOP HEADER (NO EXTRA PADDING)
            TopHeader(),


            SizedBox(height: h * 0.01),

            /// 🔙 BACK BUTTON
            AppBackButton(
              width: w,
              color: AppColors.black,
              text: loc.back,
            ),

            SizedBox(height: h * 0.02),

            /// 🏠 HOME DELIVERY
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child: GestureDetector(
                onTap: () => setState(() => isHomeDelivery = true),
                child: deliveryOption(
                  mq: mq,
                  title: "Home Delivery",
                  subtitle: "Get it delivered to your doorstep",
                  isSelected: isHomeDelivery,
                ),
              ),
            ),

            SizedBox(height: h * 0.015),

            /// 🏪 STORE PICKUP
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child: GestureDetector(
                onTap: () => setState(() => isHomeDelivery = false),
                child: deliveryOption(
                  mq: mq,
                  title: "Store Pickup",
                  subtitle: "Collect from store (No delivery fee)",
                  isSelected: !isHomeDelivery,
                ),
              ),
            ),

            SizedBox(height: h * 0.03),

            /// 📍 DELIVERY ADDRESS
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child: Text(
                "Delivery Address",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: w * 0.045,
                  color: AppColors.primary,
                ),
              ),
            ),

            SizedBox(height: h * 0.01),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child: Container(
                padding: EdgeInsets.all(w * 0.035),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextField(
                  maxLines: 3,
                  style: GoogleFonts.inter(fontSize: w * 0.04),
                  decoration: InputDecoration(
                    hintText: "Enter your complete delivery address",
                    hintStyle: GoogleFonts.inter(
                      fontSize: w * 0.038,
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),

            SizedBox(height: h * 0.03),

            /// 🔘 ACTION BUTTONS
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: h * 0.055,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade300,
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "Back To Cart",
                          style: GoogleFonts.inter(
                            fontSize: w * 0.04,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: w * 0.03),
                  Expanded(
                    child: SizedBox(
                      height: h * 0.055,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                              const PaymentMethodScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Continue",
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: w * 0.04,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: h * 0.04),
          ],
        ),
      ),
    );
  }

  /// 🔶 DELIVERY OPTION TILE
  Widget deliveryOption({
    required Size mq,
    required String title,
    required String subtitle,
    required bool isSelected,
  }) {
    return Container(
      padding: EdgeInsets.all(mq.width * 0.035),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? Colors.green : Colors.grey.shade300,
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isSelected
                ? Icons.check_circle
                : Icons.radio_button_unchecked,
            color: isSelected ? Colors.green : Colors.grey,
            size: mq.width * 0.065,
          ),
          SizedBox(width: mq.width * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: mq.width * 0.04,
                  ),
                ),
                SizedBox(height: mq.height * 0.004),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: mq.width * 0.032,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
