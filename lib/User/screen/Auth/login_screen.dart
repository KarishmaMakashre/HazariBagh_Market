import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hazari_bagh_market/User/screen/Auth/registration_screen.dart' hide AppColors;
import 'package:provider/provider.dart';
import '../../../colors/AppColors.dart';
import '../../provider/auth_provider.dart';
import '../../widgets/home_page.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      // backgroundColor: const Color(0xFFF5F6FA),
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [

          /// 🔹 HEADER
          Container(
            height: 190,
            width: double.infinity,
            padding: const EdgeInsets.only(left: 16, top: 50),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
            ),
          ),

          /// 🔹 WHITE CARD (FULL HEIGHT + SCROLL SAFE)
          Expanded(
            child: Container(
              width: double.infinity,
              transform: Matrix4.translationValues(0, -60, 0),
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            const SizedBox(height: 20),

                            const Text(
                              "Getting started",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 6),

                            const Text(
                              "Create account to continue!",
                              style: TextStyle(color: Colors.black54),
                            ),

                            const SizedBox(height: 20),

                            Row(
                              children: [
                                _socialIcon(context, "assets/Icons/google.png"),
                              ],
                            ),

                            const SizedBox(height: 20),

                            Row(
                              children: const [
                                Expanded(
                                  child: Divider(
                                    thickness: 1,
                                    color: Colors.black26,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Text(
                                    "OR",
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    thickness: 1,
                                    color: Colors.black26,
                                  ),
                                ),
                              ],
                            ),


                            const SizedBox(height: 20),

                            /// 📱 MOBILE
                            _inputField(
                              icon: Icons.phone,
                              hint: "Mobile number",
                              prefix: "+91 ",
                              keyboard: TextInputType.phone,
                              maxLength: 10,
                              onChanged: auth.setMobile,
                            ),

                            const SizedBox(height: 14),

                            /// 🔐 OTP
                            _inputField(
                              icon: Icons.lock_outline,
                              hint: "Enter OTP",
                              keyboard: TextInputType.number,
                              maxLength: 6,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              onChanged: (value) {
                                debugPrint("🔥 OTP field onChanged: $value");
                                auth.setOtp(value);
                              },
                            ),

                            const SizedBox(height: 12),


                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: auth.loading
                                  ? const Center(child: CircularProgressIndicator())
                                  : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),

                                onPressed: () async {
                                  /// 📱 SEND OTP
                                  if (auth.otp.isEmpty) {
                                    debugPrint("➡️ SEND OTP clicked");
                                    debugPrint("📱 Mobile: ${auth.mobile}");

                                    if (auth.mobile.length != 10) {
                                      _showMsg(context, "Enter valid mobile number");
                                      return;
                                    }

                                    final success = await auth.sendOtp();
                                    if (success) {
                                      _showMsg(context, "OTP sent successfully");
                                    } else {
                                      _showMsg(context, "Failed to send OTP");
                                    }
                                  }

                                  /// 🔐 VERIFY OTP / LOGIN
                                  else {
                                    debugPrint("➡️ LOGIN clicked");
                                    debugPrint("📱 Mobile: ${auth.mobile}");
                                    debugPrint("🔐 OTP: ${auth.otp}");

                                    if (auth.otp.length != 6) {
                                      _showMsg(context, "Enter valid 6 digit OTP");
                                      return;
                                    }

                                    final success = await auth.verifyOtp();
                                    if (success) {
                                      debugPrint("🎉 Login successful");
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (_) => const HomePage()),
                                      );
                                    } else {
                                      _showMsg(context, "Invalid OTP");
                                    }
                                  }
                                },

                                child: Text(
                                  auth.otp.isEmpty ? "SEND OTP" : "LOGIN",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),


                            const SizedBox(height: 30),

                            Center(
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(color: Colors.black54, fontSize: 14),
                                  children: [
                                    const TextSpan(text: "Already have an account? "),
                                    TextSpan(
                                      text: "Register Here",
                                      style: const TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          // Navigate to RegistrationScreen
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => const RegistrationScreen(),
                                            ),
                                          );
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: const TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 12,
                                  ),
                                  children: [
                                    const TextSpan(
                                      text: "By signing in you agree to our ",
                                    ),
                                    TextSpan(
                                      text: "Privacy \nPolicy",
                                      style: const TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          // TODO: Open Privacy Policy
                                        },
                                    ),
                                    const TextSpan(
                                      text: " and ",
                                    ),
                                    TextSpan(
                                      text: "Terms.",
                                      style: const TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          // TODO: Open Terms
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 INPUT FIELD
  static Widget _inputField({
    required IconData icon,
    required String hint,
    String? prefix,
    TextInputType keyboard = TextInputType.text,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
    Function(String)? onChanged,
  }) {
    return TextField(
      keyboardType: keyboard,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      decoration: InputDecoration(
        counterText: "",
        prefixText: prefix,
        prefixIcon: Icon(icon),
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF6F6F6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  /// 🔹 SOCIAL ICON
  static Widget _socialIcon(BuildContext context, String asset) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: () {
        // 🔥 Home Screen open
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 14),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black12),
        ),
        child: Image.asset(asset, height: 22),
      ),
    );
  }

  static void _showMsg(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }
}
