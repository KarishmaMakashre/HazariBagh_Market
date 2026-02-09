import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../Vendor/vendor_screens/auth/vendor_register_screen.dart';
import '../../colors/AppColors.dart';
import 'Auth/login_screen.dart';
import 'Auth/registration_screen.dart' hide AppColors;

class FoodServiceScreen extends StatefulWidget {
  const FoodServiceScreen({super.key});

  @override
  State<FoodServiceScreen> createState() => _FoodServiceScreenState();
}

class _FoodServiceScreenState extends State<FoodServiceScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<Offset> _bikeMove;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _bikeMove = Tween<Offset>(
      begin: const Offset(-1.3, 0), // ⬅ left se start
      end: Offset.zero,    // ➡ right tak
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    _controller.forward(); // 🔁 bike chalti rahe
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F7FB),
        body: Column(
          children: [

            /// 🔵 TOP CURVED SECTION
            Expanded(
              flex: 5,
              child: Stack(
                children: [

                  /// 🔵 CURVED BG
                  ClipPath(
                    clipper: BottomCurveClipper(),
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF1E4F78),
                            Color(0xFF215E8B),
                          ],
                        ),
                      ),
                    ),
                  ),

                  /// 🔙 BACK BUTTON
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, top: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.25),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios_new,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// 🚴 BIKE ANIMATION (MAIN PART)
                  Align(
                    alignment: const Alignment(0, 0.75),
                    child: SlideTransition(
                      position: _bikeMove,
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: 6),
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeInOut,
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: Offset(0, value), // 🔼🔽 bounce
                            child: child,
                          );
                        },
                        child: Image.asset(
                          "assets/images/Gemini_Generated_Image_r94uoer94uoer94u-removebg-preview.png",
                          width: w * 0.65,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// ⚪ BOTTOM CONTENT
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: w * 0.08),
                child: Column(
                  children: [

                    const SizedBox(height: 32),

                    const Text(
                      "One App",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),

                    const SizedBox(height: 14),

                    const Text(
                      "Your trusted marketplace for every category.\nFast • Reliable • Secure",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 36),

                    const _UserTypeSwitcher(),

                    const SizedBox(height: 28),

                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: w * 0.038,
                          ),
                          children: [
                            const TextSpan(text: "Already have an account? "),
                            TextSpan(
                              text: "Log In",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: w * 0.038,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const LoginScreen(),
                                    ),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    ),


                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 🔘 CUSTOMER / VENDOR SWITCH
class _UserTypeSwitcher extends StatefulWidget {
  const _UserTypeSwitcher();

  @override
  State<_UserTypeSwitcher> createState() => _UserTypeSwitcherState();
}

class _UserTypeSwitcherState extends State<_UserTypeSwitcher> {
  bool isCustomerSelected = true;

  void _navigate(Widget page) {
    Future.delayed(const Duration(milliseconds: 250), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => page),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Container(
      height: 56,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [

          AnimatedAlign(
            duration: const Duration(milliseconds: 280),
            curve: Curves.easeInOut,
            alignment: isCustomerSelected
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: Container(
              width: w * 0.38,
              height: 46,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF215E8B),
                    Color(0xFF1E4F78),
                  ],
                ),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),

          Row(
            children: [

              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() => isCustomerSelected = true);
                    _navigate(const LoginScreen());
                  },
                  child: Center(
                    child: Text(
                      "I'm a customer",
                      style: TextStyle(
                        color: isCustomerSelected
                            ? Colors.white
                            : Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() => isCustomerSelected = false);
                    _navigate(const RegisterForm());
                  },
                  child: Center(
                    child: Text(
                      "I'm a vendor",
                      style: TextStyle(
                        color: !isCustomerSelected
                            ? Colors.white
                            : Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 🔵 CURVED CLIPPER
class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 90);
    path.quadraticBezierTo(
      size.width / 2,
      size.height - 150,
      size.width,
      size.height - 90,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
