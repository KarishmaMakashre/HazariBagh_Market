import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/screen/support/support_page.dart';
import '../screen/cart/cart_page.dart';
import '../screen/categories/categories_page.dart';
import '../screen/home/home_screen.dart';
import '../screen/orders/orders_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const HomeScreen(),
    const CategoryScreen(),
    const CartScreen(),
    const MyOrdersScreen(),
    SupportPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      /// ✅ SAFE BODY
      body: SafeArea(
        child: IndexedStack(
          index: currentIndex,
          children: pages,
        ),
      ),

      /// ✅ RESPONSIVE BOTTOM NAV BAR
      bottomNavigationBar: Container(
        height: h * 0.085, // responsive height
        decoration: BoxDecoration(
          color: const Color(0xFF3670A3),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(w * 0.05),
            topRight: Radius.circular(w * 0.05),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(Icons.home, "Home", 0, w, h),
            _navItem(Icons.list, "Categories", 1, w, h),
            _navItem(Icons.shopping_cart, "Cart", 2, w, h),
            _navItem(Icons.inventory, "Orders", 3, w, h),
            _navItem(Icons.headset_mic, "Support", 4, w, h),
          ],
        ),
      ),
    );
  }

  /// 🔹 RESPONSIVE NAV ITEM
  Widget _navItem(
      IconData icon,
      String label,
      int index,
      double w,
      double h,
      ) {
    final bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() => currentIndex = index);
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: w * 0.065, // responsive icon
            color: isSelected ? Colors.white : Colors.white70,
          ),
          SizedBox(height: h * 0.004),
          Text(
            label,
            style: TextStyle(
              fontSize: w * 0.030, // responsive text
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
