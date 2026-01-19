import 'package:flutter/material.dart';

import '../../../../colors/AppColors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../widgets/app_back_button.dart';
import '../../widgets/top_header.dart';

class AutomobileScreen extends StatefulWidget {
  const AutomobileScreen({super.key});

  @override
  State<AutomobileScreen> createState() => _AutomobileScreenState();
}

class _AutomobileScreenState extends State<AutomobileScreen> {
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
            color: AppColors.jobPrimary, // reuse job primary for now
            text: loc.back,
          ),

          /// 🚗 AUTOMOBILE EMPTY STATE
          Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.08),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.directions_car_outlined,
                      size: w * 0.18,
                      color: AppColors.jobPrimary.withOpacity(0.6),
                    ),
                    SizedBox(height: h * 0.02),

                    Text(
                      "No automobile services available",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: w * 0.045,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),

                    SizedBox(height: h * 0.01),

                    Text(
                      "Vehicle repair, servicing, spare parts, and automobile "
                          "related services will appear here once they are added.",
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
                          // TODO: Navigate to Add / Explore Automobile Services
                        },
                        child: const Text(
                          "Add Automobile Service",
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
