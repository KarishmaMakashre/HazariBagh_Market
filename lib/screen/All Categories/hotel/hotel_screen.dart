import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/hotel_provider.dart';
import '../../../widgets/top_header.dart';

import 'hotel_category_card.dart'; // Import the new card

class HotelScreen extends StatelessWidget {
  const HotelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔑 Watch the HotelProvider
    final hotelProvider = context.watch<HotelProvider>();
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// 🔝 TOP HEADER
          const TopHeader(),

          /// 🔙 BACK BUTTON + TITLE
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: 10),
            child: Row(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () => Navigator.pop(context),
                  child: const Padding(
                    padding: EdgeInsets.all(6),
                    child: Icon(Icons.arrow_back, size: 18),
                  ),
                ),
                const SizedBox(width: 10),
                // 🔑 Changed "Back" to "Hotels & Restaurants" for better context
                const Text(
                  "Hotels & Restaurants",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          /// 🏨 CATEGORIES GRID
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(w * 0.04),
              // 🔑 Added Loading state check
              child: hotelProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                itemCount: hotelProvider.categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: w * 0.04,
                  mainAxisSpacing: w * 0.04,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  return HotelCategoryCard(
                    category: hotelProvider.categories[index], // Use HotelCategoryModel
                    width: w,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}