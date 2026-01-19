import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/User/widgets/user_bottom_nav.dart';
import 'package:provider/provider.dart';
import '../provider/bottom_nav_provider.dart';
import '../screen/categories/categories_page.dart';
import '../screen/home/home_screen.dart';
import '../screen/orders/orders_page.dart';
import '../screen/support/support_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<BottomNavProvider>();

    final pages = const [
      HomeScreen(),
      CategoryScreen(),
      MyOrdersScreen(),
      SupportPage(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,

      /// ⭐ VERY IMPORTANT FOR NOTCH BAR
      extendBody: true,

      body: IndexedStack(
        index: nav.currentIndex,
        children: pages,
      ),

      bottomNavigationBar: const UserBottomNav(),
    );
  }
}

