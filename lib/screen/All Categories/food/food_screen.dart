import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/screen/All%20Categories/food/restaurant_card.dart';
import '../../../colors/AppColors.dart';
import '../../../widgets/top_header.dart';

class FoodHomeScreen extends StatelessWidget {
  const FoodHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    // Renaming your size variables for clarity and consistency
    final w = width;
    final h = height;

    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        children: [

          /// 🔵 FIXED AT TOP
          const TopHeader(),

          /// 🔽 SCROLLABLE CONTENT
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: height * 0.02),

                  /// 🔙 BACK BUTTON
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.04, vertical: height * 0.01),
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back,
                              //  Use AppColors.primary
                              color: AppColors.primary,
                              size: width * 0.06),
                          SizedBox(width: width * 0.02),
                          Text(
                            "Back to Order",
                            style: TextStyle(
                              fontSize: width * 0.045,
                              fontWeight: FontWeight.w600,
                              // ✅ Use AppColors.primary
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.02),

                  /// 🔵 FOOD DELIVERY BANNER
                  Padding(
                    padding: EdgeInsets.all(w * 0.02), // Outer padding relative to width
                    child: Container(
                      width: double.infinity, // Ensures the container takes the full available width
                      padding: EdgeInsets.symmetric(
                        horizontal: w * 0.05, // Inner horizontal padding
                        vertical: h * 0.025, // Inner vertical padding
                      ),
                      decoration: BoxDecoration(
                        // ✅ Use AppColors.primary
                        color: AppColors.primary, // Background color
                        borderRadius: BorderRadius.circular(14), // Rounded corners
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Food Delivery", // Main title text
                            style: TextStyle(
                              // ✅ Use AppColors.white
                              color: AppColors.white, // Text color
                              fontSize: w * 0.055, // Font size relative to width
                              fontWeight: FontWeight.bold, // Bold font weight
                            ),
                          ),
                          SizedBox(height: h * 0.008), // Vertical space between texts
                          Text(
                            "Order delicious food from top restaurants",
                            style: TextStyle(
                              // ✅ Use AppColors.textGrey
                              color: AppColors.textGrey, // Text color (a grey)
                              fontSize: w * 0.035, // Font size relative to width
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.025),

                  /// 🏪 SECTION TITLE (Rest of the code remains the same as it doesn't use the new AppColors)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                    child: Text(
                      "Restaurants Near You",
                      style: TextStyle(
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.015),

                  /// 🍽 RESTAURANT LIST
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                    child: Column(
                      children: [
                        RestaurantCard(
                          size: size,
                          img: "assets/images/grocery.jpg",
                          name: "Spice Paradise",
                          type: "Indian • Mughlai • Biryani",
                          rating: "4.5",
                          time: "20–30 min",
                          distance: "0.8 km",
                        ),

                        SizedBox(height: height * 0.018),

                        RestaurantCard(
                          size: size,
                          img: "assets/images/electronics.jpg",
                          name: "Pizza Corner",
                          type: "Fast Food • Pizzas",
                          rating: "4.3",
                          time: "25–35 min",
                          distance: "1.2 km",
                        ),

                        SizedBox(height: height * 0.018),

                        RestaurantCard(
                          size: size,
                          img: "assets/images/clothe.jpg",
                          name: "The Dining Room",
                          type: "Cafe • Chinese • Continental",
                          rating: "4.6",
                          time: "18–28 min",
                          distance: "0.5 km",
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: height * 0.02),

                  /// 📸 BANNER IMAGE
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(width * 0.035),
                      child: Image.asset(
                        "assets/images/grocery.jpg",
                        height: height * 0.22,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}