import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hazari_bagh_market/colors/AppColors.dart';
import '../../../Model/home_model.dart';
import '../../../Model/store_model.dart';
import '../../widgets/top_header.dart';
import '../all_store_screen.dart';
import '../categories/categories_page.dart';
import '../search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _categoryScrollController = ScrollController();
  final ScrollController _storeScrollController = ScrollController();
  bool _isNavigatedCategory = false;
  bool _isNavigatedStore = false;

  @override
  void initState() {
    super.initState();

    // Scroll listener for Category row
    _categoryScrollController.addListener(() {
      if (_categoryScrollController.position.pixels >=
              _categoryScrollController.position.maxScrollExtent - 5 &&
          !_isNavigatedCategory) {
        _isNavigatedCategory = true;
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 400),
            pageBuilder: (_, animation, __) => const CategoryScreen(),
            transitionsBuilder: (_, animation, __, child) {
              final slideAnimation = Tween(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation);
              return SlideTransition(position: slideAnimation, child: child);
            },
          ),
        ).then((_) => _isNavigatedCategory = false);
      }
    });

    // Scroll listener for Nearby Stores
    _storeScrollController.addListener(() {
      if (_storeScrollController.position.pixels >=
              _storeScrollController.position.maxScrollExtent - 5 &&
          !_isNavigatedStore) {
        _isNavigatedStore = true;
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 400),
            pageBuilder: (_, animation, __) => const AllStoreScreen(),
            transitionsBuilder: (_, animation, __, child) {
              final slideAnimation = Tween(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation);
              return SlideTransition(position: slideAnimation, child: child);
            },
          ),
        ).then((_) => _isNavigatedStore = false);
      }
    });
  }

  @override
  void dispose() {
    _categoryScrollController.dispose();
    _storeScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // ✅ WHITE STATUS BAR
        statusBarIconBrightness: Brightness.light, // Android icons dark
        statusBarBrightness: Brightness.light, // iOS icons dark
      ),
    );

    return Scaffold(
      backgroundColor: Color(0xffF6F6F6FF),
      body: Stack(
        children: [
          // Scrollable content
          Padding(
            padding: EdgeInsets.only(top: 80), // space for fixed TopHeader
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.04),

                  /// 🔍 SEARCH BAR
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: const Duration(
                              milliseconds: 350,
                            ),
                            pageBuilder: (_, animation, __) =>
                                const SearchScreen(),
                            transitionsBuilder: (_, animation, __, child) {
                              final slide =
                                  Tween(
                                    begin: const Offset(
                                      1,
                                      0,
                                    ), // ➡ right to left
                                    end: Offset.zero,
                                  ).animate(
                                    CurvedAnimation(
                                      parent: animation,
                                      curve: Curves.easeInOut,
                                    ),
                                  );
                              return SlideTransition(
                                position: slide,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: TextField(
                          enabled: false, // 🔥 typing disable on Home
                          style: TextStyle(
                            fontSize: width * 0.038,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            hintText: "Search ...",
                            hintStyle: TextStyle(color: Colors.grey.shade500),
                            prefixIcon: Icon(
                              Icons.search,
                              color: AppColors.primary,
                            ),
                            suffixIcon: Icon(
                              Icons.tune,
                              color: Colors.grey.shade500,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: height * 0.018,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// 🖼 IMAGE + TITLE
                  Padding(
                    padding: EdgeInsets.all(width * 0.04),
                    child: Container(
                      height: width * 0.45,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: const DecorationImage(
                          image: AssetImage(
                            "assets/images/avin-cp-OlXUUQedQyM-unsplash.jpg",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(width * 0.04),
                        alignment: Alignment.bottomLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.black.withOpacity(0.4),
                        ),
                        child: Text(
                          "HazariBagh Market",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 0.06,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  /// 📦 CATEGORY ROW
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                    child: Text(
                      "Category",
                      style: TextStyle(
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),

                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.035),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: homeCategories.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, // 4 cards per row
                        crossAxisSpacing: width * 0.03,
                        mainAxisSpacing: height * 0.015,
                        childAspectRatio:
                            0.85, // 👈 height control (adjust if needed)
                      ),
                      itemBuilder: (context, index) {
                        final category = homeCategories[index];

                        return Material(
                          borderRadius: BorderRadius.circular(18),
                          elevation: 4,
                          shadowColor: Colors.black26,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(18),
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration: const Duration(
                                    milliseconds: 350,
                                  ),
                                  pageBuilder: (_, animation, __) =>
                                      category.screen,
                                  transitionsBuilder:
                                      (_, animation, __, child) {
                                        final slide = Tween(
                                          begin: const Offset(1, 0),
                                          end: Offset.zero,
                                        ).animate(animation);
                                        return SlideTransition(
                                          position: slide,
                                          child: child,
                                        );
                                      },
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 0.015,
                                vertical: height * 0.004,
                              ),
                              child: Column(
                                children: [
                                  /// ICON AREA
                                  Expanded(
                                    flex: 6,
                                    child: Center(
                                      child: Container(
                                        padding: EdgeInsets.all(width * 0.02),
                                        decoration: BoxDecoration(
                                          color: Colors.blue.shade50,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.asset(
                                          category.image,
                                          height: width * 0.08,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),

                                  /// SPACE
                                  SizedBox(height: height * 0.006),

                                  /// TEXT AREA (2 lines max)
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      category.titleKey,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: width * 0.028,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  /// 🛍 NEARBY STORES
                  Padding(
                    padding: EdgeInsets.only(
                      left: width * 0.02,
                      right: width * 0.02,
                      top: 1, // 👈 chhota value
                    ),
                    child: Text(
                      "Nearby Stores",
                      style: TextStyle(
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  SizedBox(
                    height: width * 0.38,
                    child: ListView.builder(
                      controller: _storeScrollController,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: nearbyStores.length,
                      padding: EdgeInsets.symmetric(horizontal: width * 0.035),
                      itemBuilder: (context, index) {
                        final store = nearbyStores[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 14),
                          child: Material(
                            elevation: 6,
                            shadowColor: Colors.black26,
                            borderRadius: BorderRadius.circular(20),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {},
                              child: Container(
                                width: width * 0.32,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.asset(
                                        store.image,
                                        height: width * 0.18,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(height: height * 0.008),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.015,
                                      ),
                                      child: Text(
                                        store.nameKey,
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: width * 0.03,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: height * 0.005),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          size: width * 0.035,
                                          color: Colors.amber,
                                        ),
                                        SizedBox(width: width * 0.01),
                                        Text(
                                          store.rating.toString(),
                                          style: TextStyle(
                                            fontSize: width * 0.026,
                                            color: Colors.grey[800],
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: height * 0.015),

                  /// 🔶 Special Weekend Offer Card
                  Center(
                    child: Container(
                      width: width * 0.9,
                      padding: EdgeInsets.all(width * 0.05),
                      margin: EdgeInsets.symmetric(vertical: height * 0.02),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.primary, AppColors.primaryLight],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 12,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.local_offer,
                                color: Colors.white,
                                size: width * 0.07,
                              ),
                              SizedBox(width: width * 0.02),
                              Text(
                                "Special Weekend Offer!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width * 0.05,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black45,
                                      offset: Offset(1, 1),
                                      blurRadius: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: height * 0.01),
                          Text(
                            "Get flat 30% off on all orders",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: width * 0.035,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: height * 0.008),
                          Text(
                            "Valid till 7/10",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: width * 0.03,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.015),

                  /// 🔹 SECOND CATEGORY GRID (All Categories included)
                  Container(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.02,
                        vertical: height * 0.02,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// 🔹 SECTIONS
                          ...categorySections.map((section) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// SECTION TITLE
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: height * 0.015,
                                  ),
                                  child: Text(
                                    section.title,
                                    style: TextStyle(
                                      fontSize: width * 0.04,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                /// 🔥 ONE BIG CARD (ALL ITEMS INSIDE)
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(width * 0.02),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(18),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.08),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      /// 🔹 FIRST ROW (BIG + 2 SMALL)
                                      Column(
                                        children: [
                                          /// 🔷 FIRST ROW (BIG + 2 SMALL VERTICAL)
                                          Column(
                                            children: [
                                              /// 🔷 FIRST ROW (BIG + 2 SMALL SIDE-BY-SIDE)
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  /// 🔷 BIG ITEM
                                                  SizedBox(
                                                    height: height * 0.12,
                                                    width: width * 0.42,
                                                    child: _bigCategoryItem(
                                                      context,
                                                      section.items[0],
                                                      width,
                                                      height,
                                                    ),
                                                  ),

                                                  SizedBox(width: width * 0.06),

                                                  /// 🔷 2 SMALL ITEMS (ROW ONLY)
                                                  SizedBox(
                                                    height: height * 0.12,
                                                    width: width * 0.42,
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child:
                                                              _smallCategoryItem(
                                                                context,
                                                                section
                                                                    .items[1],
                                                                width,
                                                                height,
                                                              ),
                                                        ),
                                                        SizedBox(
                                                          width: width * 0.02,
                                                        ),
                                                        Expanded(
                                                          child:
                                                              _smallCategoryItem(
                                                                context,
                                                                section
                                                                    .items[2],
                                                                width,
                                                                height,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              SizedBox(height: height * 0.02),

                                              /// 🔹 SECOND ROW (4 SMALL ITEMS)
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: List.generate(4, (
                                                  index,
                                                ) {
                                                  return SizedBox(
                                                    width: width * 0.21,
                                                    child: _bottomSmallItem(
                                                      context,
                                                      section.items[index + 3],
                                                      width,
                                                      height,
                                                    ),
                                                  );
                                                }),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: height * 0.03),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: height * 0.015),

          // 🔝 TOP HEADER (fixed)
          const Positioned(top: 0, left: 0, right: 0, child: TopHeader()),
          SizedBox(height: height * 0.03),
        ],
      ),
    );
  }

  Widget _smallCategoryItem(
    BuildContext context,
    CategoryItem item,
    double w,
    double h,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => item.screen));
      },
      child: Container(
        height: h * 0.08,
        padding: EdgeInsets.all(w * 0.02),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(child: Image.network(item.imageUrl, fit: BoxFit.contain)),
            Text(
              item.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: w * 0.024,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomSmallItem(
    BuildContext context,
    CategoryItem item,
    double w,
    double h,
  ) {
    return SizedBox(
      width: w * 0.20,
      child: _smallCategoryItem(context, item, w, h),
    );
  }

  Widget _bigCategoryItem(
    BuildContext context,
    CategoryItem item,
    double w,
    double h,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => item.screen));
      },
      child: Container(
        height: h * 0.18,
        padding: EdgeInsets.all(w * 0.03),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Image.network(item.imageUrl, fit: BoxFit.contain)),
            SizedBox(height: h * 0.01),
            Text(
              item.title.replaceAll("\n", " "),
              style: TextStyle(
                fontSize: w * 0.035,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
