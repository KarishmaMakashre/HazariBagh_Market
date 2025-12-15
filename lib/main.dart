import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/provider/auth_provider.dart';
import 'package:hazari_bagh_market/provider/bottom_nav_provider.dart';
import 'package:hazari_bagh_market/provider/cart_provider.dart';
import 'package:hazari_bagh_market/provider/chat_Provider.dart';
import 'package:hazari_bagh_market/provider/fashion_provider.dart';
import 'package:hazari_bagh_market/provider/food_provider.dart';
import 'package:hazari_bagh_market/provider/grocery_provider.dart';
import 'package:hazari_bagh_market/provider/home_provider.dart';
import 'package:hazari_bagh_market/provider/hotel_provider.dart';
import 'package:hazari_bagh_market/provider/jobs_services_provider.dart';
import 'package:hazari_bagh_market/provider/property_provider.dart';
import 'package:hazari_bagh_market/provider/store_provider.dart';
import 'package:hazari_bagh_market/provider/support_provider.dart';
import 'package:hazari_bagh_market/screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'Vendor/VendorProvider/dashboard_provider.dart';
import 'Vendor/VendorProvider/vendor_bottom_nav_provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
        ChangeNotifierProvider(create: (_) => StoreProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => JobsServicesProvider()),
        ChangeNotifierProvider(create: (_) => PropertyProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => VendorBottomNavProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => SupportProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => FashionProvider()),
        ChangeNotifierProvider(create: (_) => HotelProvider()),
        ChangeNotifierProvider(create: (_) => GroceryProvider()),
        ChangeNotifierProvider(create: (_) => FoodProvider()),

      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        fontFamily: 'Cambria',
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}