import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'User/provider/auth_provider.dart';
import 'User/provider/bottom_nav_provider.dart';
import 'User/provider/cart_provider.dart';
import 'User/provider/chat_Provider.dart';
import 'User/provider/fashion_provider.dart';
import 'User/provider/food_provider.dart';
import 'User/provider/grocery_provider.dart';
import 'User/provider/home_provider.dart';
import 'User/provider/hotel_provider.dart';
import 'User/provider/jobs_services_provider.dart';
import 'User/provider/language_provider.dart';
import 'User/provider/payment_provider.dart';
import 'User/provider/profile_provider.dart';
import 'User/provider/property_provider.dart';
import 'User/provider/store_provider.dart';
import 'User/provider/support_provider.dart';
import 'User/provider/theme_provider.dart';
import 'User/screen/splash_screen.dart';
import 'Vendor/VendorProvider/Fashion_Provider.dart';
import 'Vendor/VendorProvider/agriculture_provider.dart';
import 'Vendor/VendorProvider/category_provider.dart';
import 'Vendor/VendorProvider/dashboard_provider.dart';
import 'Vendor/VendorProvider/education_provider.dart';
import 'Vendor/VendorProvider/food_store_provider.dart';
import 'Vendor/VendorProvider/govt_provider.dart';
import 'Vendor/VendorProvider/grocery_store_provider.dart';
import 'Vendor/VendorProvider/hotel_provider.dart';
import 'Vendor/VendorProvider/job_provider.dart';
import 'Vendor/VendorProvider/order_provider.dart';
import 'Vendor/VendorProvider/travel_provider.dart';
import 'Vendor/VendorProvider/vendor_Property_Provider.dart';
import 'Vendor/VendorProvider/vendor_bottom_nav_provider.dart';
import 'Vendor/VendorProvider/vendor_profile_provider.dart';
import 'Vendor/VendorProvider/vendor_reports_provider.dart';
import 'Vendor/VendorProvider/vendor_store_provider.dart' hide StoreProvider;
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ INIT HIVE
  await Hive.initFlutter();

  // ✅ OPEN REQUIRED BOXES
  await Hive.openBox('appBox');     // for routes / app data
  await Hive.openBox('userBox');    // if you store user data
  await Hive.openBox('cartBox');    // if cart uses hive

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
        ChangeNotifierProvider(create: (_) => StoreProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => JobsServicesProvider()),
        ChangeNotifierProvider(create: (_) => PropertyProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => SupportProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => FashionProvider()),
        ChangeNotifierProvider(create: (_) => HotelProvider()),
        ChangeNotifierProvider(create: (_) => GroceryProvider()),
        ChangeNotifierProvider(create: (_) => FoodProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => PaymentProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => VendorProfileProvider()),
        ChangeNotifierProvider(create: (_) => VendorReportsProvider()),
        ChangeNotifierProvider(create: (_) => VendorBottomNavProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => GroceryStoreProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => VendorStoreProvider()),
        ChangeNotifierProvider(create: (_) => GovtProvider()),
        ChangeNotifierProvider(create: (_) => FashionProductProvider()),
        ChangeNotifierProvider(create: (_) => FoodStoreProvider()),
        ChangeNotifierProvider(create: (_) => JobProvider()),
        ChangeNotifierProvider(create: (_) => VendorPropertyProvider()),
        ChangeNotifierProvider(create: (_) => EducationProvider()),
        ChangeNotifierProvider(create: (_) => VendorHotelProvider()),
        ChangeNotifierProvider(create: (_) => VendorAgricultureProvider()),
        ChangeNotifierProvider(create: (_) => VendorTravelProvider()),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final languageProvider = context.watch<LanguageProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      /// 🌍 LANGUAGE CONTROL (🔥 THIS IS THE KEY)
      locale: languageProvider.locale,

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,

      /// 🌗 THEME
      themeMode: themeProvider.themeMode,

      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        cardColor: Colors.grey.shade200,
        fontFamily: 'Merriweather_48pt-MediumItalic',
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black,
        cardColor: Colors.grey.shade900,
        fontFamily: 'Merriweather_48pt-MediumItalic',
      ),

      home: const SplashScreen(),
    );
  }
}

