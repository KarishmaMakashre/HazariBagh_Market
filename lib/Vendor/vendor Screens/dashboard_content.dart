// import 'package:flutter/material.dart';
// import 'package:hazari_bagh_market/Vendor/vendor%20Screens/product_screen.dart';
// import 'package:provider/provider.dart';
// import '../VendorProvider/vendor_bottom_nav_provider.dart';
// import '../widget/vendor_bottom_Nav.dart';
// import 'analytics_screen.dart';
// import 'vendor_dashboard_home_screen.dart';
// import 'order_screen.dart';
//
// class DashboardContent extends StatelessWidget {
//   const DashboardContent({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final nav = Provider.of<VendorBottomNavProvider>(context);
//
//     final screens = const [
//       DashboardHomeScreen(),
//       ProductsScreen(),
//       OrdersScreen(),
//       AnalyticsScreen(),
//     ];
//
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       body: screens[nav.currentIndex],
//       bottomNavigationBar: VendorBottomNavBar(
//         currentIndex: nav.currentIndex,
//         onTabTapped: nav.changeIndex,
//       ),
//     );
//   }
// }
//
//
