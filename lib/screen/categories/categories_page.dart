import 'package:flutter/material.dart';
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

                  /// TITLE
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

                  /// CATEGORY GRID (6 only)
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: homeCategories.length > 6 ? 6 : homeCategories.length,
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
                              Image.asset(item.image, height: w * 0.12),
                              SizedBox(height: w * 0.02),
                              Text(
                                item.title,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: w * 0.03,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: h * 0.02),

                  /// EXPLORE STORES TITLE
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Explore Stores By Category & \nDistance",
                          style: TextStyle(
                            fontSize: w * 0.045,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const AllStoreScreen()),
                          );
                        },
                        child: const Text(
                          "View All",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: h * 0.015),

                  /// 🔥 DYNAMIC STORE LIST
                  SizedBox(
                    height: h * 0.27,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: nearbyStores.length,
                      itemBuilder: (context, index) {
                        final store = nearbyStores[index];

                        return Container(
                          width: w * 0.42,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: h * 0.11,
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(12)),
                                  child: Image.asset(
                                    store.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.all(w * 0.02),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      store.name,
                                      style: TextStyle(
                                        fontSize: w * 0.035,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    SizedBox(height: h * 0.005),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          store.distance,
                                          style: TextStyle(
                                              color: Colors.blue, fontSize: w * 0.028),
                                        ),
                                        Text(
                                          "${store.rating} ⭐",
                                          style: TextStyle(
                                              color: Colors.orange, fontSize: w * 0.028),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: h * 0.01),

                                    SizedBox(
                                      height: h * 0.035,
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFF3670A3),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                        ),
                                        onPressed: () {
                                          Provider.of<StoreProvider>(
                                            context,
                                            listen: false,
                                          ).setStore(store);

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => const ViewStoreScreen(),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          "Visit Store",
                                          style: TextStyle(
                                              fontSize: w * 0.028, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: h * 0.03),

                  /// ⭐ BANNER IMAGE SECTION (Reduced Height)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                      height: h * 0.18,   // ⬅️ Reduced height (previously full auto height)
                      width: double.infinity,
                      child: Image.asset(
                        "assets/images/electronics.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),


                  SizedBox(height: h * 0.03),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(w * 0.08),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Column(
                      children: [
                        Text(
                          "Special Weekend Offer!",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          "Get flat 30% off on all orders",
                          style: TextStyle(fontSize: 16, color: Colors.white),
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
