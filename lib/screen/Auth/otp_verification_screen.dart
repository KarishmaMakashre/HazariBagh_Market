import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hazari_bagh_market/colors/AppColors.dart';
import 'package:hazari_bagh_market/widgets/home_page.dart';

import '../../provider/auth_provider.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController otpController = TextEditingController();

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final mq = MediaQuery.of(context).size;
    final width = mq.width;
    final height = mq.height;

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: width,
            height: height,
            child: Image.asset(
              'assets/images/loginbg.png',
              fit: BoxFit.cover,
            ),
          ),

          Container(color: AppColors.darkOverlay),

          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.07),
                child: Column(
                  children: [
                    SizedBox(height: height * 0.03),

                    /// LOGO
                    Transform.translate(
                      offset: Offset(0, -height * 0.01),
                      child: Container(
                        padding: EdgeInsets.all(width * 0.030),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                        child: Container(
                          padding: EdgeInsets.all(width * 0.03),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.white,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              "assets/images/logo.png",
                              height: width * 0.22,
                              width: width * 0.22,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.02),

                    Text(
                      "Sign in with your mobile number",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: width * 0.034,
                      ),
                    ),

                    SizedBox(height: height * 0.03),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Mobile Number",
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.034,
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.008),

                    TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        hintText: "+91 ${authProvider.mobile}",
                        hintStyle: TextStyle(
                          color: AppColors.textGrey,
                          fontSize: width * 0.038,
                        ),
                        filled: true,
                        fillColor: AppColors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.03),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.022),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Enter OTP",
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.034,
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.008),

                    TextField(
                      controller: otpController,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      decoration: InputDecoration(
                        counterText: "",
                        hintText: "Enter OTP",
                        filled: true,
                        fillColor: AppColors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.03),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.01),

                    /// ---------- TIMER + RESEND ----------
                    authProvider.otpTimeLeft > 0
                        ? Text(
                      "OTP expires in ${authProvider.otpTimeLeft} seconds",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: width * 0.032,
                      ),
                    )
                        : GestureDetector(
                      onTap: authProvider.resendOtp,
                      child: Text(
                        "Resend OTP",
                        style: TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: width * 0.035,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.028),

                    /// VERIFY BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: height * 0.055,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(width * 0.03),
                          ),
                        ),
                        onPressed: () {
                          if (otpController.text.trim().length == 6) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const HomePage(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please enter valid OTP"),
                              ),
                            );
                          }
                        },
                        child: Text(
                          "Verify & Log In",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.020),

                    Row(
                      children: [
                        Expanded(child: Divider(color: AppColors.white)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                          child: Text("or", style: TextStyle(color: AppColors.white)),
                        ),
                        Expanded(child: Divider(color: AppColors.white)),
                      ],
                    ),

                    SizedBox(height: height * 0.040),

                    Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        Text(
                          "By signing in you agree to our ",
                          style: TextStyle(
                            fontSize: width * 0.032,
                            color: Colors.white70,
                          ),
                        ),
                        Text(
                          "Privacy Policy",
                          style: TextStyle(
                            color: AppColors.linkBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.032,
                          ),
                        ),
                        Text(
                          " and ",
                          style: TextStyle(
                            fontSize: width * 0.032,
                            color: Colors.white70,
                          ),
                        ),
                        Text(
                          "Terms.",
                          style: TextStyle(
                            color: AppColors.linkBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.032,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: height * 0.02),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
