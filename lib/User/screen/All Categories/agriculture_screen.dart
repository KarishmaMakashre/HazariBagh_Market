import 'package:flutter/material.dart';

import '../../../../colors/AppColors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../widgets/app_back_button.dart';
import '../../widgets/top_header.dart';

class AgricultureScreen extends StatefulWidget {
  const AgricultureScreen({super.key});

  @override
  State<AgricultureScreen> createState() => _AgricultureScreenState();
}

class _AgricultureScreenState extends State<AgricultureScreen> {
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
          const TopHeader(),

          SizedBox(height: h * 0.02),

          /// 🔙 BACK BUTTON
          AppBackButton(
            width: w,
            color: AppColors.jobPrimary, // you can create agriculturePrimary later
            text: loc.back,
          ),

          /// 🌾 AGRICULTURE EMPTY STATE
          Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.08),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.agriculture_outlined,
                      size: w * 0.18,
                      color: AppColors.jobPrimary.withOpacity(0.6),
                    ),
                    SizedBox(height: h * 0.02),

                    Text(
                      "No agriculture services available",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: w * 0.045,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),

                    SizedBox(height: h * 0.01),

                    Text(
                      "Crop information, farming tools, and agriculture services "
                          "are not added yet. Add details to help farmers get support.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: w * 0.034,
                        color: Colors.grey.shade600,
                      ),
                    ),

                    SizedBox(height: h * 0.03),

                    /// ➕ ACTION BUTTON
                    SizedBox(
                      height: h * 0.055,
                      width: w * 0.7,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.jobPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () {
                          // TODO: Navigate to Add / Explore Agriculture Services
                        },
                        child: const Text(
                          "Add Agriculture Services",
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
