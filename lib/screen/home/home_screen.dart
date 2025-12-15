import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Model/home_model.dart';
import '../../Model/store_model.dart';
import '../../all_categories_screen.dart';
import '../../widgets/top_header.dart';
import '../../provider/home_provider.dart';
import '../all_store_screen.dart';
import '../store_details_screen.dart';   // <-- your store details screen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();

  final List<String> sliderImages = [
    "assets/images/clothe.jpg",
    "assets/images/grocery.jpg",
    "assets/images/electronics.jpg",
  ];

  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      final provider = Provider.of<HomeProvider>(context, listen: false);

      int nextPage = provider.bannerIndex + 1;
      if (nextPage == sliderImages.length) nextPage = 0;

      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );

      provider.changeBanner(nextPage);
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final w = mq.width;
    final h = mq.height;

    final provider = Provider.of<HomeProvider>(context);

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

                  // ---------------- WELCOME CARD ----------------
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(w * 0.06),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3670A3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome, User!",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: w * 0.06,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Discover local stores & amazing deals",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: w * 0.035,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: h * 0.015),

                  // ---------------- SLIDER WITH OFFER LABEL ----------------
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const AllStoreScreen()),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                            height: h * 0.22,
                            child: PageView.builder(
                              controller: _pageController,
                              itemCount: sliderImages.length,
                              onPageChanged: provider.changeBanner,
                              itemBuilder: (context, index) {
                                return Stack(
                                  children: [
                                    Image.asset(
                                      sliderImages[index],
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),

                                    // OFFER LABEL
                                    Positioned(
                                      left: 12,
                                      top: 70,
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.yellow.shade700,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: const Text(
                                          "50% OFF",
                                          style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),

                                    // OFFER TEXT
                                    Positioned(
                                      left: 12,
                                      bottom: 20,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            "Big sale This week",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            "on all grocery items",
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),

                      // Slider dots
                      Positioned(
                        bottom: 10,
                        child: Row(
                          children: List.generate(
                            sliderImages.length,
                                (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              height: 8,
                              width: provider.bannerIndex == index ? 18 : 8,
                              decoration: BoxDecoration(
                                color: provider.bannerIndex == index
                                    ? Colors.white
                                    : Colors.white54,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: h * 0.02),

                  // ---------------- CATEGORIES ----------------
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

                  // ---------------- NEARBY STORES ----------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Nearby Stores",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const AllStoreScreen()),
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

                  SizedBox(height: h * 0.015),

                  // ---------------- STORE HORIZONTAL LIST ----------------
                  SizedBox(
                    height: h * 0.22,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: nearbyStores.length,
                      itemBuilder: (context, index) {
                        final store = nearbyStores[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => StoreDetailsScreen(store: store),
                              ),
                            );
                          },
                          child: Container(
                            width: w * 0.42,
                            margin: const EdgeInsets.only(right: 14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  offset: const Offset(0, 4),
                                  blurRadius: 12,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(18),
                                        topRight: Radius.circular(18),
                                      ),
                                      child: Image.asset(
                                        store.image,
                                        height: h * 0.13,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),

                                    Positioned(
                                      right: 8,
                                      top: 8,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.star, color: Colors.orange, size: 12),
                                            const SizedBox(width: 3),
                                            Text(
                                              store.rating.toString(),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: h * 0.008),

                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    store.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    store.category,
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.location_on, size: 14, color: Colors.grey),
                                      const SizedBox(width: 3),
                                      Text(
                                        store.distance,
                                        style: const TextStyle(
                                          color: Colors.black54,
                                          fontSize: 12,
                                        ),
                                      )
                                    ],
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

                  // ---------------- OFFER CARD ----------------
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

                  SizedBox(height: h * 0.05),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
