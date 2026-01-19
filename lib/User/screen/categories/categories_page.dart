import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../Model/home_model.dart';

import '../../widgets/top_header.dart';
import '../All Categories/Grocery/grocery_screen.dart';
import '../All Categories/food/food_screen.dart';

/// 🔹 CATEGORY ITEM MODEL
class CategoryItem {
  final String imageUrl; // 🔥 NETWORK IMAGE
  final String title;
  final Widget screen;

  CategoryItem({
    required this.imageUrl,
    required this.title,
    required this.screen,
  });
}

/// 🔹 CATEGORY SECTION MODEL
class CategorySection {
  final String title;
  final List<CategoryItem> items;

  CategorySection({
    required this.title,
    required this.items,
  });
}

/// 🔹 CATEGORY DATA (NETWORK IMAGES)
final List<CategorySection> categorySections = [
  CategorySection(
    title: "Grocery & Kitchen",
    items: [
      CategoryItem(
        imageUrl:
        "https://media.istockphoto.com/id/1257538623/photo/fresh-food-delivery-service.webp?a=1&b=1&s=612x612&w=0&k=20&c=NhXYgaZxVIEerVKluaYMzHlh7eIzRqyhxnP7HYMz7aY=",
        title: "Fruits &\nVegetables",
        screen: const GroceryScreen(),
      ),
      CategoryItem(
        imageUrl:
        "https://media.istockphoto.com/id/1265062578/photo/different-food-on-wooden-background-space-for-text.jpg?s=612x612&w=0&k=20&c=wcfovZK5t9KhNXuWdb0_Ifmf0TN9aB3AC2nkhU47ers=",
        title: "Dairy, Bread\n& Eggs",
        screen: const GroceryScreen(),
      ),
      CategoryItem(
        imageUrl:
        "https://media.istockphoto.com/id/2209790995/photo/different-types-of-cereals-isolated-on-white.jpg?s=612x612&w=0&k=20&c=Nnbc_q4IXoSvJPB-7tMA_x5eG9oBtxAgHfHSvJYodGs=",
        title: "Atta, Rice,\nOil & Dals",
        screen: const GroceryScreen(),
      ),
      CategoryItem(
        imageUrl:
        "https://media.istockphoto.com/id/1186459351/photo/close-up-rice-with-shrimp-paste-sauce-and-boiled-egg-many-vegetable-fried-fish-thai-style.jpg?s=612x612&w=0&k=20&c=kpoonl8rbPMdrFIJIXCS_uXlnsG8yJ971JzK4du8evo=",
        title: "Meat, Fish\n& Eggs",
        screen: const GroceryScreen(),
      ),
      CategoryItem(
        imageUrl:
        "https://media.istockphoto.com/id/1477202287/photo/healthy-vegetarian-food-concept-assortment-of-dried-fruits-nuts-and-seeds-on-white-background.jpg?s=612x612&w=0&k=20&c=OmbDvDVlCOWBfret-ZDjpIB8d0jz89xQrLoh6PMWS7U=",
        title: "Masala &\nDry Fruits",
        screen: const GroceryScreen(),
      ),
      CategoryItem(
        imageUrl:
        "https://media.istockphoto.com/id/1200881751/photo/close-up-and-selective-focus-appetizers-with-spicy-sardine-mixed-with-herb-placed-on-lettuce.jpg?s=612x612&w=0&k=20&c=9j4aS8MfKP7HtADDLR-OjqSvbTM28AVQZd8NRami0vU=",
        title: "Breakfast\n& Sauces",
        screen: const GroceryScreen(),
      ),
      CategoryItem(
        imageUrl:
        "https://media.istockphoto.com/id/458413277/photo/american-grocery-collection.jpg?s=1024x1024&w=is&k=20&c=0DKuLpLmbP9G3iK3kzcY0kHVEmsfOVSw8hi7XWq6G9w=",
        title: "Packaged\nFood",
        screen: const GroceryScreen(),
      ),
    ],
  ),

  CategorySection(
    title: "Snacks & Drinks",
    items: [
      CategoryItem(
        imageUrl:
        "https://media.istockphoto.com/id/2093789071/photo/tea-and-coffee-on-isolated-background.jpg?s=612x612&w=0&k=20&c=2tyu-a5mcy61-d9Bp-JX0Mr0At8R-hnL5ZQAqEUyucw=",
        title: "Tea, Coffee\n& More",
        screen: const FoodHomeScreen(),
      ),
      CategoryItem(
        imageUrl:
        "https://media.istockphoto.com/id/692687270/photo/homemade-popsicles-with-strawberry.jpg?s=612x612&w=0&k=20&c=J2S6OuZZLeRgHJ-U1wUQxMGttc14QYI_1C53jQFN6no=",
        title: "Ice Creams\n& More",
        screen: const FoodHomeScreen(),
      ),
      CategoryItem(
        imageUrl:
        "https://media.istockphoto.com/id/1304670658/photo/a-variety-of-prepackaged-food-products-in-plastic-boxes.jpg?s=612x612&w=0&k=20&c=6wh-TbCthswWuhu7Fqe9333BxFCKaVaVkJxX4w7dFT8=",
        title: "Frozen\nFood",
        screen: const FoodHomeScreen(),
      ),
      CategoryItem(
        imageUrl:
        "https://media.istockphoto.com/id/938017064/photo/marshmallow-and-piece-of-cake.jpg?s=612x612&w=0&k=20&c=_9iLsJy4XqW7X0hcrhR1D7l2KH91cewWOEtofKUdVbE=",
        title: "Sweet\nCravings",
        screen: const FoodHomeScreen(),
      ),
      CategoryItem(
        imageUrl:
        "https://plus.unsplash.com/premium_photo-1720905255499-f034fae0a7b8?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTd8fENvbGQlMjBEcmlua3MlNUNuJTI2JTIwSnVpY2VzfGVufDB8fDB8fHww",
        title: "Cold Drinks\n& Juices",
        screen: const FoodHomeScreen(),
      ),
      CategoryItem(
        imageUrl:
        "https://media.istockphoto.com/id/1156137228/photo/group-of-gujarati-snacks-like-jalebi-fafda-thepla-khaman-dhokla-aloo-bhujiya-khandvi-khakra.jpg?s=612x612&w=0&k=20&c=yb8bEGQTm2WAs3EKALMn0B0BWGm4-EArzZZu9b1KjOM=",
        title: "Munchies",
        screen: const FoodHomeScreen(),
      ),
      CategoryItem(
        imageUrl:
        "https://images.unsplash.com/photo-1583743089695-4b816a340f82?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fEJpc2N1aXRzJTVDbiUyNiUyMENvb2tpZXN8ZW58MHx8MHx8fDA%3D",
        title: "Biscuits\n& Cookies",
        screen: const FoodHomeScreen(),
      ),
    ],
  ),
];

/// 🔹 CATEGORY SCREEN
class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  void _open(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // ✅ WHITE STATUS BAR
        statusBarIconBrightness: Brightness.light, // Android icons dark
        statusBarBrightness: Brightness.light, // iOS icons dark
      ),
    );


    return Scaffold(
      backgroundColor: Color(0xffF6F6F6FF),
      body: Column(
        children: [
          TopHeader(),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: w * 0.02,
                vertical: h * 0.02,
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
                          padding: EdgeInsets.symmetric(vertical: h * 0.015),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /// 🏷 SECTION TITLE
                              Text(
                                section.title,
                                style: TextStyle(
                                  fontSize: w * 0.04,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              /// 👀 VIEW ALL
                              InkWell(
                                onTap: () {
                                  // 👉 yahan aap "All Category Screen" ya
                                  // specific section ka screen open kar sakte ho
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => GroceryScreen(), // change if needed
                                    ),
                                  );
                                },
                                child: Text(
                                  "View all",
                                  style: TextStyle(
                                    fontSize: w * 0.032,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF16415F), // 🔵 Primary color
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// 🔥 ONE BIG CARD (ALL ITEMS INSIDE)
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(w * 0.02),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  /// 🔷 BIG ITEM
                                  SizedBox(
                                    height: h * 0.12,
                                    width: w * 0.42,
                                    child: _bigCategoryItem(
                                      context,
                                      section.items[0],
                                      w,
                                      h,
                                    ),
                                  ),

                                  SizedBox(width: w * 0.06),

                                  /// 🔷 2 SMALL ITEMS (ROW ONLY)
                                  SizedBox(
                                    height: h * 0.12,
                                    width: w * 0.42,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: _smallCategoryItem(
                                            context,
                                            section.items[1],
                                            w,
                                            h,
                                          ),
                                        ),
                                        SizedBox(width: w * 0.02),
                                        Expanded(
                                          child: _smallCategoryItem(
                                            context,
                                            section.items[2],
                                            w,
                                            h,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: h * 0.02),

                              /// 🔹 SECOND ROW (4 SMALL ITEMS)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: List.generate(4, (index) {
                                  return SizedBox(
                                    width: w * 0.21,
                                    child: _bottomSmallItem(
                                      context,
                                      section.items[index + 3],
                                      w,
                                      h,
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



                        SizedBox(height: h * 0.03),
                      ],
                    );
                  }),

                ],
              ),
            ),
          ),
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => item.screen),
        );
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
            Expanded(
              child: Image.network(
                item.imageUrl,
                fit: BoxFit.contain,
              ),
            ),
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => item.screen),
        );
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
            Expanded(
              child: Image.network(
                item.imageUrl,
                fit: BoxFit.contain,
              ),
            ),
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

