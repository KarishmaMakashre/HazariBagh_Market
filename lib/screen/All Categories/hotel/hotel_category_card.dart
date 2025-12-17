import 'package:flutter/material.dart';

import '../../../Model/hotel_category_model.dart';
import 'hotel_product_list_screen.dart';


class HotelCategoryCard extends StatelessWidget {
  final HotelCategoryModel category;
  final double width;

  const HotelCategoryCard({
    super.key,
    required this.category,
    required this.width,
  });

  // 🟢 HOTEL CARD - Includes navigation logic
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        // 🔑 NAVIGATION LOGIC
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HotelProductListScreen(
              categoryTitle: category.title, // Pass the category title
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          children: [
            /// 🖼 IMAGE
            Expanded(
              flex: 7,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(14),
                ),
                child: Image.asset(
                  category.image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  // Add a placeholder/error handling if possible
                ),
              ),
            ),

            /// 📛 TITLE
            Expanded(
              flex: 3,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    category.title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: width * 0.032,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}