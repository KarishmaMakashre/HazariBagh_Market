import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../colors/AppColors.dart';
import '../../provider/auth_provider.dart';
import '../flash_screen.dart';
import 'otp_verification_screen.dart';
import 'registration_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final mq = MediaQuery.of(context).size;
    final height = mq.height;
    final width = mq.width;

    return WillPopScope(
      onWillPop: () async {
        /// ✅ BACK PRESS → FLASH SCREEN
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const FlashScreen()),
        );
        return false; // ❌ default back ko block
      },
      child: Scaffold(
        body: Stack(
          children: [

            /// 🔵 BACKGROUND IMAGE
            SizedBox(
              height: height,
              width: width,
              child: Image.asset(
                "assets/images/loginbg.png",
                fit: BoxFit.cover,
              ),
            ),

            /// 🔵 DARK OVERLAY
            Container(
              height: height,
              width: width,
              color: AppColors.darkOverlay,
            ),

            /// 🔵 MAIN CONTENT
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.07),
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    SizedBox(height: height * 0.12),

                    /// 🔵 LOGO
                    Transform.translate(
                      offset: Offset(0, -height * 0.02),
                      child: Container(
                        padding: EdgeInsets.all(width * 0.030),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
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
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.015),

                    /// 🔵 SUB TITLE
                    Text(
                      "Sign in with your mobile number or Google",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: width * 0.035,
                      ),
                    ),

                    SizedBox(height: height * 0.03),

                    /// 🔵 MOBILE LABEL
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Mobile number",
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.01),

                    /// 🔵 MOBILE INPUT
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.inputBackground,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: auth.setMobile,
                        style: TextStyle(fontSize: width * 0.04),
                        decoration: InputDecoration(
                          counterText: "",
                          prefixText: "+91 ",
                          prefixStyle: TextStyle(
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: height * 0.015,
                          ),
                          border: InputBorder.none,
                          hintText: "Enter mobile number",
                          hintStyle: TextStyle(
                            color: AppColors.greyText,
                            fontSize: width * 0.04,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.02),

                    /// 🔵 SEND OTP BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: height * 0.06,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          elevation: 0,
                          side: const BorderSide(
                            color: AppColors.otpBorder,
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          if (auth.mobile.length == 10) {
                            auth.sendOtp();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                const OtpVerificationScreen(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Please enter valid mobile number"),
                              ),
                            );
                          }
                        },
                        child: Text(
                          "Send OTP",
                          style: TextStyle(
                            fontSize: width * 0.045,
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.060),

                    /// ───── OR ─────
                    Row(
                      children: const [
                        Expanded(child: Divider(color: Colors.white)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text("or",
                              style: TextStyle(color: Colors.white)),
                        ),
                        Expanded(child: Divider(color: Colors.white)),
                      ],
                    ),

                    SizedBox(height: height * 0.03),

                    /// 🔵 GOOGLE LOGIN
                    SizedBox(
                      width: double.infinity,
                      height: height * 0.055,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        icon: Image.asset(
                          "assets/Icons/google.png",
                          height: 20,
                        ),
                        label: Text(
                          "Sign in with Google",
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: width * 0.04,
                          ),
                        ),
                        onPressed: auth.googleSignIn,
                      ),
                    ),

                    SizedBox(height: height * 0.03),

                    /// 🔵 REGISTER
                    /// 🔵 REGISTER
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "New Users? ",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: width * 0.038,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => RegistrationScreen()),
                            );
                          },
                          child: Text(
                            "Register Here",
                            style: TextStyle(
                              color: AppColors.linkBlue, // 🔵 BLUE like image
                              fontSize: width * 0.042,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: height * 0.015),

                    /// 🔵 PRIVACY POLICY + TERMS
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "By signing in you agree to our ",
                        style: TextStyle(
                          fontSize: width * 0.032,
                          color: AppColors.white.withOpacity(0.8),
                          height: 1.4,
                        ),
                        children: [
                          TextSpan(
                            text: "Privacy\nPolicy",
                            style: TextStyle(
                              color: AppColors.linkBlue,
                              fontWeight: FontWeight.w600,
                            ),
                            // recognizer: TapGestureRecognizer()
                            //   ..onTap = () {
                            //     // 🔵 OPEN PRIVACY POLICY
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (_) => const PrivacyPolicyScreen(),
                            //       ),
                            //     );
                            //   },
                          ),
                          const TextSpan(text: " and "),
                          TextSpan(
                            text: "Terms.",
                            style: TextStyle(
                              color: AppColors.linkBlue,
                              fontWeight: FontWeight.w600,
                            ),
                            // recognizer: TapGestureRecognizer()
                            //   ..onTap = () {
                                // 🔵 OPEN TERMS SCREEN
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (_) => const TermsScreen(),
                                //   ),
                                // );
                              // },
                          ),
                        ],
                      ),
                    ),


                    SizedBox(height: height * 0.04),

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
