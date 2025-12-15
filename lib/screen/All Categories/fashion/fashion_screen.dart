import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hazari_bagh_market/widgets/top_header.dart';
import '../../../provider/fashion_provider.dart';
import '../../../colors/AppColors.dart';
import 'service_detail_screen.dart';

class FashionScreen extends StatelessWidget {
  const FashionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FashionProvider>();
    // Correctly using w for width and h for height
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 🔝 HEADER
            const TopHeader(),
            SizedBox(height: h * 0.01),
            Padding(
              // Corrected: width -> w, height -> h
              padding: EdgeInsets.symmetric(
                  horizontal: w * 0.04, vertical: h * 0.01),
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back,
                        color: const Color(0xFF3670A3),
                        // Corrected: width -> w
                        size: w * 0.06),
                    // Corrected: width -> w
                    SizedBox(width: w * 0.02),
                    Text(
                      "Back",
                      style: TextStyle(
                        // Corrected: width -> w
                        fontSize: w * 0.045,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF3670A3),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: h * 0.01),

            /// 🔵 TOP BANNER
            Padding(
              padding: EdgeInsets.all(w * 0.02), // Outer padding relative to width
              child: Container(
                // *** CHANGE MADE HERE: Set width to double.infinity ***
                width: double.infinity, // Ensures the container takes the full available width
                padding: EdgeInsets.symmetric(
                  horizontal: w * 0.05, // Inner horizontal padding
                  vertical: h * 0.025, // Inner vertical padding
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary, // Background color
                  borderRadius: BorderRadius.circular(14), // Rounded corners
                ),
                child: Column(
                  // Correct for left-alignment
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Fashion Store", // Main title text
                      style: TextStyle(
                        color: AppColors.white, // Text color
                        fontSize: w * 0.055, // Font size relative to width
                        fontWeight: FontWeight.bold, // Bold font weight
                      ),
                    ),
                    SizedBox(height: h * 0.008), // Vertical space between texts
                    Text(
                      "Explore latest fashion & trends", // Subtitle text
                      style: TextStyle(
                        color: AppColors.textGrey, // Text color (a grey)
                        fontSize: w * 0.035, // Font size relative to width
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: h * 0.015),
            /// 🖼 DOUBLE PROMO BANNERS
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child: Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.asset(
                        "assets/images/offer.jpg",
                        height: h * 0.13,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: w * 0.03),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.asset(
                        "assets/images/sales.png",
                        height: h * 0.13,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: h * 0.03),



            /// 📂 CATEGORIES
            _sectionTitle("Categories", w),
            SizedBox(height: h * 0.015),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child: Row(
                children: provider.categories.map((cat) {
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      height: h * 0.14,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image.asset(
                              cat.image,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),

                          /// DARK OVERLAY
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  AppColors.black.withOpacity(0.6),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),

                          /// TITLE
                          Positioned(
                            left: 12,
                            bottom: 12,
                            child: Text(
                              cat.title,
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: w * 0.04,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: h * 0.03),

            /// 🛍 SERVICES
            _sectionTitle("Services", w),
            SizedBox(height: h * 0.015),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: provider.services.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: w * 0.03,
                  mainAxisSpacing: w * 0.03,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final service = provider.services[index];

                  return InkWell(
                    borderRadius: BorderRadius.circular(w * 0.035),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ServiceDetailScreen(service: service),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(w * 0.035),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadow,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [

                          /// IMAGE
                          Expanded(
                            flex: 7,
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(w * 0.035),
                              ),
                              child: Image.asset(
                                service.image,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),

                          /// TITLE
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: w * 0.015),
                              child: Center(
                                child: Text(
                                  service.title.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: w * 0.028,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2,
                                    letterSpacing: 0.3,
                                    color: AppColors.textDark,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: h * 0.04),
          ],
        ),
      ),
    );
  }

  /// 🔹 SECTION TITLE
  Widget _sectionTitle(String title, double w) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.04),
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.primary,
          fontSize: w * 0.045,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}