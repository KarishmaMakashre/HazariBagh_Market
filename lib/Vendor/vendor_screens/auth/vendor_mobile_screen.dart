import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/Vendor/vendor_screens/auth/vendor_otp_screen.dart';
import '../../vendorColors/AppColors.dart';

class VendorMobileScreen extends StatefulWidget {
  const VendorMobileScreen({super.key});

  @override
  State<VendorMobileScreen> createState() => _VendorMobileScreenState();
}

class _VendorMobileScreenState extends State<VendorMobileScreen> {
  final mobileCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        title: const Text("Mobile Verification"),
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: w * 0.05,
          vertical: h * 0.02,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔹 HEADER
              const Text(
                "Verify Your Mobile Number",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "We will send a 6-digit OTP to your mobile number",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 30),

              /// 📱 MOBILE INPUT
              TextFormField(
                controller: mobileCtrl,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "Mobile number is required";
                  }
                  if (v.length != 10) {
                    return "Enter valid 10 digit mobile number";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Mobile Number",
                  prefixIcon: Icon(Icons.phone, color: primary),
                  filled: true,
                  fillColor: AppColors.fieldBg,
                  counterText: "",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const Spacer(),

              /// ▶ SEND OTP BUTTON
              SizedBox(
                width: double.infinity,
                height: h * 0.065,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Send OTP",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) return;

                    final result = await Navigator.push<bool>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const VendorOtpScreen(),
                      ),
                    );

                    /// ✅ OTP VERIFIED
                    if (result == true) {
                      Navigator.pop(context, true);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
