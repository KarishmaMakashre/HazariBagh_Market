import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../vendorColors/AppColors.dart';
import 'vendor_doc_bank_screen.dart';

class VendorRegisterScreen extends StatefulWidget {
  const VendorRegisterScreen({super.key});

  @override
  State<VendorRegisterScreen> createState() => _VendorRegisterScreenState();
}

class _VendorRegisterScreenState extends State<VendorRegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final ownerCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final mobileCtrl = TextEditingController();
  final shopNameCtrl = TextEditingController();
  final shopDescCtrl = TextEditingController();

  final streetCtrl = TextEditingController();
  final cityCtrl = TextEditingController();
  final stateCtrl = TextEditingController();
  final pincodeCtrl = TextEditingController();
  final landmarkCtrl = TextEditingController();

  String? category;
  String? storeType;
  File? vendorPhoto;

  final picker = ImagePicker();

  /* ================= IMAGE PICKER ================= */

  Future<void> _pickImage() async {
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );
    if (picked != null) {
      setState(() => vendorPhoto = File(picked.path));
    }
  }

  /* ================= VALIDATORS ================= */

  String? _required(String? v) =>
      v == null || v.trim().isEmpty ? "Required" : null;

  String? _validateName(String? v) {
    if (v == null || v.isEmpty) return "Required";
    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(v)) {
      return "Only alphabets allowed";
    }
    return null;
  }

  String? _validateEmail(String? v) {
    if (v == null || v.isEmpty) return "Email required";
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v)) {
      return "Enter valid email";
    }
    return null;
  }

  String? _validateMobile(String? v) {
    if (v == null || v.isEmpty) return "Mobile required";
    if (!RegExp(r'^[0-9]{10}$').hasMatch(v)) {
      return "Enter 10 digit mobile";
    }
    return null;
  }

  String? _validatePincode(String? v) {
    if (v == null || v.isEmpty) return "Pincode required";
    if (!RegExp(r'^[0-9]{6}$').hasMatch(v)) {
      return "Enter valid 6 digit pincode";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Vendor Registration"),
        backgroundColor: primary,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: AppColors.lightBg,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(w * 0.05),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 10),

              /// 🔢 STEP INDICATOR
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _StepCircle(text: "1", active: true, color: primary),
                  const _StepLine(),
                  _StepCircle(text: "2", active: false, color: primary),
                ],
              ),

              const SizedBox(height: 28),

              /// 📸 PHOTO PICKER
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 58,
                  backgroundColor: primary,
                  child: CircleAvatar(
                    radius: 54,
                    backgroundColor: Colors.white,
                    backgroundImage:
                    vendorPhoto != null ? FileImage(vendorPhoto!) : null,
                    child: vendorPhoto == null
                        ? Icon(Icons.camera_alt, size: 34, color: primary)
                        : null,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              _input(ownerCtrl, "Owner Name", Icons.person, primary,
                  validator: _validateName),

              _input(emailCtrl, "Email", Icons.email, primary,
                  keyboard: TextInputType.emailAddress,
                  validator: _validateEmail),

              _input(mobileCtrl, "Mobile Number", Icons.phone, primary,
                  keyboard: TextInputType.number,
                  maxLength: 10,
                  formatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: _validateMobile),

              _input(shopNameCtrl, "Shop Name", Icons.store, primary,
                  validator: _required),

              _input(shopDescCtrl, "Shop Description", Icons.description,
                  primary,
                  maxLines: 3,
                  validator: _required),

              _dropdown(
                label: "Category",
                value: category,
                items: const ["Retail", "Food", "Electronics", "Services"],
                onChanged: (v) => setState(() => category = v),
              ),

              _dropdown(
                label: "Store Type",
                value: storeType,
                items: const ["Fashion", "Grocery"],
                onChanged: (v) => setState(() => storeType = v),
              ),

              /// 📍 ADDRESS
              _input(streetCtrl, "Street / Area", Icons.location_on, primary,
                  validator: _required),

              _input(cityCtrl, "City", Icons.location_city, primary,
                  validator: _validateName),

              _input(stateCtrl, "State", Icons.map, primary,
                  validator: _validateName),

              _input(pincodeCtrl, "Pincode", Icons.pin, primary,
                  keyboard: TextInputType.number,
                  maxLength: 6,
                  formatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: _validatePincode),

              _input(landmarkCtrl, "Landmark (Optional)", Icons.place, primary,
                  validator: (_) => null),

              const SizedBox(height: 30),

              /// ▶ CONTINUE BUTTON
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (category == null ||
                          storeType == null ||
                          vendorPhoto == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "Select category, store type & photo"),
                          ),
                        );
                        return;
                      }

                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const VendorDocBankScreen()),
                      );
                    }
                  },
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 INPUT FIELD
  Widget _input(
      TextEditingController ctrl,
      String label,
      IconData icon,
      Color primary, {
        int maxLines = 1,
        int? maxLength,
        TextInputType keyboard = TextInputType.text,
        List<TextInputFormatter>? formatters,
        String? Function(String?)? validator,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: ctrl,
        maxLines: maxLines,
        maxLength: maxLength,
        keyboardType: keyboard,
        inputFormatters: formatters,
        validator: validator,
        decoration: InputDecoration(
          counterText: "",
          labelText: label,
          prefixIcon: Icon(icon, color: primary),
          filled: true,
          fillColor: AppColors.fieldBg,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  /// 🔹 DROPDOWN
  Widget _dropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: value,
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: onChanged,
        validator: (v) => v == null ? "Select $label" : null,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: AppColors.fieldBg,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

/// 🔢 STEP CIRCLE
class _StepCircle extends StatelessWidget {
  final String text;
  final bool active;
  final Color color;

  const _StepCircle(
      {required this.text, required this.active, required this.color});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 18,
      backgroundColor: active ? color : Colors.grey.shade300,
      child: Text(
        text,
        style: TextStyle(
            color: active ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _StepLine extends StatelessWidget {
  const _StepLine();

  @override
  Widget build(BuildContext context) {
    return Container(width: 60, height: 2, color: Colors.grey.shade400);
  }
}
