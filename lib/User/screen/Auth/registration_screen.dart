import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hazari_bagh_market/Vendor/vendor Screens/vendor_dashboard_home_screen.dart';
import '../../../colors/AppColors.dart';
import '../flash_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  String? selectedGender;
  bool agree = false;

  final TextEditingController fullName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const FlashScreen()),
              (route) => false,
        );
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            /// BACKGROUND
            Container(
              height: h,
              width: w,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/loginbg.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Container(color: Colors.black.withOpacity(0.65)),

            /// CONTENT
            SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: w * 0.07),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: h * 0.05),

                      /// LOGO
                      _logo(w),

                      SizedBox(height: h * 0.02),

                      Text(
                        "Create Profile",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: w * 0.055,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      SizedBox(height: h * 0.025),

                      /// GOOGLE LOGIN
                      SizedBox(
                        width: double.infinity,
                        height: h * 0.055,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          icon: Image.asset(
                            "assets/Icons/google.png",
                            height: h * 0.025,
                          ),
                          label: Text(
                            "Sign in with Google",
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: w * 0.04,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                const VendorDashboardHomeScreen(),
                              ),
                            );
                          },
                        ),
                      ),

                      SizedBox(height: h * 0.02),

                      _orDivider(w),

                      SizedBox(height: h * 0.02),

                      _textField(
                        "Full Name",
                        Icons.person,
                        fullName,
                        TextInputType.name,
                            (v) => v!.isEmpty ? "Enter full name" : null,
                        h,
                        w,
                      ),

                      _textField(
                        "Email Address",
                        Icons.email,
                        email,
                        TextInputType.emailAddress,
                            (v) =>
                        !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v!)
                            ? "Invalid email"
                            : null,
                        h,
                        w,
                      ),

                      _textField(
                        "Phone Number",
                        Icons.phone,
                        phone,
                        TextInputType.phone,
                            (v) =>
                        v!.length != 10 ? "Enter valid mobile" : null,
                        h,
                        w,
                        maxLength: 10,
                      ),

                      /// GENDER
                      Container(
                        height: h * 0.055,
                        padding: EdgeInsets.symmetric(horizontal: w * 0.03),
                        decoration: _boxDecoration(),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedGender,
                            hint: const Text("Gender"),
                            items: ["Male", "Female", "Other"]
                                .map(
                                  (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ),
                            )
                                .toList(),
                            onChanged: (val) =>
                                setState(() => selectedGender = val),
                          ),
                        ),
                      ),

                      SizedBox(height: h * 0.015),

                      _textField(
                        "Home Address",
                        Icons.location_on,
                        address,
                        TextInputType.text,
                            (v) => v!.isEmpty ? "Enter address" : null,
                        h,
                        w,
                      ),

                      /// TERMS
                      Row(
                        children: [
                          Checkbox(
                            value: agree,
                            onChanged: (v) => setState(() => agree = v!),
                          ),
                          Expanded(
                            child: Text(
                              "I agree with Terms and Conditions",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: w * 0.03,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: h * 0.015),

                      /// REGISTER BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: h * 0.055,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                          ),
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) return;

                            if (selectedGender == null) {
                              _snack("Select gender");
                              return;
                            }

                            if (!agree) {
                              _snack("Accept terms & conditions");
                              return;
                            }

                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (_) =>
                            //     const VendorActivationScreen(),
                            //   ),
                            // );
                          },
                          child: Text(
                            "Register & Continue",
                            style: GoogleFonts.poppins(
                              fontSize: w * 0.04,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: h * 0.03),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// HELPERS --------------------------------------------------

  Widget _logo(double w) {
    return ClipOval(
      child: Image.asset(
        "assets/images/logo.png",
        height: w * 0.25,
        width: w * 0.25,
      ),
    );
  }

  Widget _orDivider(double w) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Colors.white30)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            "OR",
            style: GoogleFonts.poppins(color: Colors.white70),
          ),
        ),
        const Expanded(child: Divider(color: Colors.white30)),
      ],
    );
  }

  Widget _textField(
      String hint,
      IconData icon,
      TextEditingController controller,
      TextInputType type,
      String? Function(String?) validator,
      double h,
      double w, {
        int? maxLength,
      }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: _boxDecoration(),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        maxLength: maxLength,
        validator: validator,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hint,
          counterText: "",
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: h * 0.017),
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
    );
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }
}
