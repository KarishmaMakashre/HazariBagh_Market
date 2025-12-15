import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/screen/flash_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    /// 5 sec delay
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const FlashScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          /// FULL-SCREEN BACKGROUND IMAGE
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/loginbg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// BLUR EFFECT
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: Container(
              color: Colors.black.withOpacity(0.3), // slight dark overlay
            ),
          ),

          /// CENTER LOGO
          Center(
            child: Image.asset(
              "assets/images/logo.png",
              height: 120,
              width: 120,
            ),
          ),

        ],
      ),
    );
  }
}
