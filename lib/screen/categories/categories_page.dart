import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hazari_bagh_market/provider/store_provider.dart';
import 'package:hazari_bagh_market/screen/all_store_screen.dart';
import 'package:hazari_bagh_market/screen/categories/view_store_screen.dart';
import 'package:provider/provider.dart';
import '../../Model/home_model.dart';
import '../../Model/store_model.dart';
import '../../all_categories_screen.dart';
import '../../widgets/top_header.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  /// 🔥 COMMON METHOD (Card + Button dono ke liye)
  void _openStore(BuildContext context, StoreModel store) {
    Provider.of<StoreProvider>(context, listen: false).setStore(store);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ViewStoreScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          const TopHeader(),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(w * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// 🔹 CATEGORIES TITLE
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Categories",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const AllCategoriesScreen()),
                        ),
                        child: const Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF3670A3),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: h * 0.01),

                  /// 🔹 CATEGORY GRID
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: homeCategories.length > 6
                        ? 6
                        : homeCategories.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      final item = homeCategories[index];

                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => item.screen),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              /// 🔹 IMAGE
                              Image.asset(
                                item.image,
                                height: w * 0.12,
                                fit: BoxFit.contain,
                              ),

                              SizedBox(height: w * 0.02),

                              /// 🔹 TITLE (GOOGLE FONT)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                child: Text(
                                  item.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                    fontSize: w * 0.032,
                                    fontWeight: FontWeight.w600, // SemiBold look
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),


                  SizedBox(height: h * 0.02),

                  /// 🔹 EXPLORE STORES TITLE
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// 🔹 TITLE
                      Expanded(
                        child: Text(
                          "Explore Stores By Category &\nDistance",
                          style: GoogleFonts.inter(
                            fontSize: w * 0.045,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                            height: 1.3,
                          ),
                        ),
                      ),

                      /// 🔹 VIEW ALL BUTTON
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AllStoreScreen(),
                          ),
                        ),
                        child: Text(
                          "View All",
                          style: GoogleFonts.inter(
                            fontSize: w * 0.034,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),


                  SizedBox(height: h * 0.015),

                  /// 🔥 STORE CARD LIST (FULL CARD CLICKABLE)
                  SizedBox(
                    height: h * 0.25, // ⬅️ flexible but safe height
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: nearbyStores.length,
                      itemBuilder: (context, index) {
                        final store = nearbyStores[index];

                        return InkWell(
                          borderRadius: BorderRadius.circular(14),
                          onTap: () => _openStore(context, store),
                          child: Container(
                            width: w * 0.40, // ⬅️ responsive width
                            margin: const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                /// 🖼 IMAGE (ASPECT RATIO BASED)
                                AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(14),
                                    ),
                                    child: Image.asset(
                                      store.image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                                /// 📄 CONTENT
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(w * 0.03),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          store.name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: w * 0.04,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),

                                        const SizedBox(height: 6),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              store.distance,
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: w * 0.032,
                                              ),
                                            ),
                                            Text(
                                              "${store.rating} ⭐",
                                              style: TextStyle(
                                                color: Colors.orange,
                                                fontSize: w * 0.032,
                                              ),
                                            ),
                                          ],
                                        ),

                                        const Spacer(),

                                        /// 🔘 BUTTON
                                        SizedBox(
                                          width: double.infinity,
                                          height: 40, // ⬅️ minimum touch size
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: const Color(0xFF3670A3),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                            ),
                                            onPressed: () => _openStore(context, store),
                                            child: const Text(
                                              "Visit Store",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
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


                  SizedBox(height: h * 0.03),

                  /// 🔹 BANNER
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                      height: h * 0.20,
                      width: double.infinity,
                      child: Image.asset(
                        "assets/images/specOffer20%Off.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  SizedBox(height: h * 0.03),

                  /// 🔹 OFFER
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 28,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFFF9800), // orange
                          Color(0xFFFFB300), // yellow-orange
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.4),
                          blurRadius: 14,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Special Weekend\nOffer!",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Get flat 30% off on all orders\nabove ₹999",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white70,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: h * 0.03),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
