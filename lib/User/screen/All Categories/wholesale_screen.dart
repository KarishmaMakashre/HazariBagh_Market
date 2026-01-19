import 'package:flutter/material.dart';

import '../../../../colors/AppColors.dart';
import '../../../../l10n/app_localizations.dart';

class WholesaleScreen extends StatefulWidget {
  const WholesaleScreen({super.key});

  @override
  State<WholesaleScreen> createState() => _WholesaleScreenState();
}

class _WholesaleScreenState extends State<WholesaleScreen> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final loc = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      /// 🔝 SAFE APP BAR (no Grid / List inside)
      appBar: AppBar(
        backgroundColor: AppColors.propertyAccent,
        elevation: 0,
        title: const Text(
          'Wholesale',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.08),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// 📦 ICON
              Icon(
                Icons.inventory_2_outlined,
                size: w * 0.18,
                color: AppColors.propertyAccent.withOpacity(0.6),
              ),

              SizedBox(height: h * 0.02),

              /// 📝 TITLE
              // Text(
              //   // loc.wholesaleComingSoon ?? "Wholesale listings coming soon",
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     fontSize: w * 0.045,
              //     fontWeight: FontWeight.w600,
              //     color: Colors.black87,
              //   ),
              // ),

              SizedBox(height: h * 0.01),

              /// 📄 DESCRIPTION
              Text(
                "Find bulk products, distributors, and suppliers "
                    "at competitive wholesale prices.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: w * 0.034,
                  color: Colors.grey.shade600,
                ),
              ),

              SizedBox(height: h * 0.03),

              /// 🚀 ACTION BUTTON
              SizedBox(
                height: h * 0.055,
                width: w * 0.7,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.propertyAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    // TODO: Navigate to wholesale listings
                  },
                  child: const Text(
                    "Browse Wholesale Deals",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
