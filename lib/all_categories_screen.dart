import 'package:flutter/material.dart';
import '../../Model/home_model.dart';
import '../../widgets/top_header.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    /// -------------------------------
    /// 🟦 GROUPING DATA USING TITLES
    /// -------------------------------

    final dailyNeeds = homeCategories.where((e) =>
    e.title.contains("Grocery") ||
        e.title.contains("Food") ||
        e.title.contains("Water") ||
        e.title.contains("Hotels")
    ).toList();

    final shopping = homeCategories.where((e) =>
    e.title.contains("Fashion") ||
        e.title.contains("Hardware") ||
        e.title.contains("Wholesale")
    ).toList();

    final property = homeCategories.where((e) =>
    e.title.contains("Rental") ||
        e.title.contains("Plot") ||
        e.title.contains("Home")
    ).toList();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: Column(
        children: [


          /// 🔵 TOP HEADER
          const TopHeader(),

          /// 🔙 BACK BUTTON (CUSTOM BAR)
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);  // ⬅ back to home
                    },
                    child: const Icon(Icons.arrow_back,
                        size: 26, color: Color(0xFF3670A3)),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Back",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3670A3),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// MAIN BODY
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// ---------------- DAILY NEEDS ----------------
                  _buildSectionTitle("Daily Needs"),
                  _buildGrid(dailyNeeds, width),

                  /// ---------------- SHOPPING ----------------
                  _buildSectionTitle("Shopping"),
                  _buildGrid(shopping, width),

                  /// ---------------- PROPERTY ----------------
                  _buildSectionTitle("Property"),
                  _buildGrid(property, width),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// SECTION TITLE
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF3670A3),
        ),
      ),
    );
  }

  /// GRID VIEW FOR EACH GROUP
  Widget _buildGrid(List<HomeCategoryModel> items, double width) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.78,
      ),
      itemBuilder: (context, index) {
        final item = items[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => item.screen),
            );
          },
          child: Container(
            padding: EdgeInsets.all(width * 0.025),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: width * 0.14,
                  child: Image.asset(
                    item.image,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: width * 0.02),
                Text(
                  item.title,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: width * 0.032,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
