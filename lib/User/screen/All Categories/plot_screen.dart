import 'package:flutter/material.dart';

import '../../../../colors/AppColors.dart';
import '../../../../l10n/app_localizations.dart';

import '../../widgets/app_back_button.dart';
import '../../widgets/top_header.dart';

class PlotScreen extends StatefulWidget {
  const PlotScreen({super.key});

  @override
  State<PlotScreen> createState() => _PlotScreenState();
}

class _PlotScreenState extends State<PlotScreen> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final loc = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔝 TOP HEADER
          TopHeader(
),

          SizedBox(height: h * 0.02),

          /// 🔙 BACK BUTTON
          AppBackButton(
            width: w,
            color: AppColors.propertyAccent,
            text: loc.back,
          ),

          /// 🏞️ PLOT EMPTY STATE
          Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.08),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.terrain,
                      size: w * 0.18,
                      color: AppColors.propertyAccent.withOpacity(0.6),
                    ),
                    SizedBox(height: h * 0.02),

                    Text(
                      "Plots & land listings coming soon",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: w * 0.045,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),

                    SizedBox(height: h * 0.01),

                    Text(
                      "Residential and commercial plot listings "
                          "will appear here to help you find the perfect land "
                          "for your future plans.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: w * 0.034,
                        color: Colors.grey.shade600,
                      ),
                    ),

                    SizedBox(height: h * 0.03),

                    /// 🌍 ACTION BUTTON
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
                          // TODO: Navigate to plot enquiry / map view
                        },
                        child: const Text(
                          "Explore Plots",
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
          ),
        ],
      ),
    );
  }
}
