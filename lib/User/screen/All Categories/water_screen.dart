import 'package:flutter/material.dart';
import '../../../../colors/AppColors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../widgets/app_back_button.dart';
import '../../widgets/top_header.dart';

class WaterScreen extends StatefulWidget {
  const WaterScreen({super.key});

  @override
  State<WaterScreen> createState() => _WaterScreenState();
}

class _WaterScreenState extends State<WaterScreen> {
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
            color: AppColors.jobPrimary,
            text: loc.back,
          ),

          /// 🚰 LOGICAL EMPTY STATE
          Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.08),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.water_drop_outlined,
                      size: w * 0.18,
                      color: AppColors.jobPrimary.withOpacity(0.6),
                    ),
                    SizedBox(height: h * 0.02),

                    Text(
                      "No water connections yet",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: w * 0.045,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),

                    SizedBox(height: h * 0.01),

                    Text(
                      "You haven't added any water connection. "
                          "Add one to start managing water details.",
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
                      width: w * 0.65,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.jobPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () {
                          // TODO: Navigate to Add Water Screen
                        },
                        child: const Text(
                          "Add Water Connection",
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
