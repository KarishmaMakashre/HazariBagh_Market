import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Model/home_model.dart';
import '../../Model/store_model.dart';
import '../../all_categories_screen.dart';
import '../../widgets/top_header.dart';
import '../../provider/home_provider.dart';
import '../all_store_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  late AnimationController _fadeController;

  final List<String> sliderImages = [
    "assets/images/clothe.jpg",
    "assets/images/grocery.jpg",
    "assets/images/electronics.jpg",
  ];

  Timer? timer;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();

    /// 🔁 AUTO SLIDER
    timer = Timer.periodic(const Duration(seconds: 3), (_) {
      final provider = context.read<HomeProvider>();
      int next = provider.bannerIndex + 1;
      if (next == sliderImages.length) next = 0;

      _pageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      provider.changeBanner(next);
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    _fadeController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _openPage(Widget page) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, a, __) => FadeTransition(
          opacity: a,
          child: SlideTransition(
            position:
            Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                .animate(a),
            child: page,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final provider = context.watch<HomeProvider>();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: FadeTransition(
        opacity: _fadeController,
        child: Column(
          children: [
            const TopHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(w * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// 🔵 WELCOME CARD
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(w * 0.06),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3670A3),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome, User!",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "Discover local stores & amazing deals",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: h * 0.02),

                    /// 🖼️ SLIDER
                    GestureDetector(
                      onTap: () => _openPage(const AllStoreScreen()),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: SizedBox(
                          height: h * 0.24,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: sliderImages.length,
                            onPageChanged: provider.changeBanner,
                            itemBuilder: (_, index) {
                              return Image.asset(
                                sliderImages[index],
                                width: double.infinity,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: h * 0.03),

                    /// 🟦 CATEGORIES
                    _sectionHeader(
                      title: "Categories",
                      onViewAll: () =>
                          _openPage(const AllCategoriesScreen()),
                    ),

                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                      homeCategories.length > 6 ? 6 : homeCategories.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (_, index) {
                        final item = homeCategories[index];
                        return GestureDetector(
                          onTap: () => _openPage(item.screen),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  blurRadius: 10,
                                )
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(item.image, height: w * 0.12),
                                const SizedBox(height: 6),
                                Text(item.title,
                                    textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: h * 0.03),

                    /// 🏬 NEARBY STORES
                    _sectionHeader(
                      title: "Nearby Stores",
                      onViewAll: () => _openPage(const AllStoreScreen()),
                    ),
                    SizedBox(height: h * 0.01),


                    SizedBox(
                      height: 210,
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
                                  builder: (_) => const AllStoreScreen(),
                                ),
                              );
                            },
                            child: Container(
                              width: 170,
                              margin: const EdgeInsets.only(right: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(14),
                                    ),
                                    child: Image.asset(
                                      store.image,
                                      height: 110,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          store.name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),
                                        ),
                                        Text(
                                          store.category,
                                          style: const TextStyle(
                                            fontSize: 11,
                                            color: Colors.grey,
                                          ),
                                        ),
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


                    SizedBox(height: h * 0.04),

                    /// 🎁 SPECIAL WEEKEND OFFER (✅ CORRECT PLACE)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: w * 0.06,
                        vertical: h * 0.035,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFFF9800),
                            Color(0xFFFFB300),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.orange.withOpacity(0.35),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: const Column(
                        children: [
                          Text(
                            "Special Weekend\nOffer!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Get flat 30% off on all orders\nabove ₹999",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: h * 0.04),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(
      {required String title, required VoidCallback onViewAll}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style:
            const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        GestureDetector(
          onTap: onViewAll,
          child: const Text(
            "View All",
            style: TextStyle(
                color: Color(0xFF3670A3), fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
