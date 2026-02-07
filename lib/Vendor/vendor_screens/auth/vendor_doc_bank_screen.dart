import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../vendorColors/AppColors.dart';
import 'vendor_mobile_screen.dart';

class VendorDocBankScreen extends StatefulWidget {
  const VendorDocBankScreen({super.key});

  @override
  State<VendorDocBankScreen> createState() => _VendorDocBankScreenState();
}

class _VendorDocBankScreenState extends State<VendorDocBankScreen> {
  final _formKey = GlobalKey<FormState>();

  final aadhaarCtrl = TextEditingController();
  final panCtrl = TextEditingController();
  final gstCtrl = TextEditingController();
  final accHolderCtrl = TextEditingController();
  final accNoCtrl = TextEditingController();
  final ifscCtrl = TextEditingController();
  final bankNameCtrl = TextEditingController();

  final picker = ImagePicker();

  File? aadhaarDoc;
  File? panDoc;
  File? gstDoc;
  File? ifscDoc;
  File? shopImg;

  /* ================= VALIDATORS ================= */

  String? _validateAadhaar(String? v) {
    if (v == null || v.isEmpty) return "Aadhaar is required";
    if (!RegExp(r'^[0-9]{12}$').hasMatch(v)) {
      return "Enter valid 12-digit Aadhaar";
    }
    return null;
  }

  String? _validatePAN(String? v) {
    if (v == null || v.isEmpty) return "PAN is required";
    if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$').hasMatch(v)) {
      return "Format: ABCDE1234F";
    }
    return null;
  }

  String? _validateGST(String? v) {
    if (v == null || v.isEmpty) return "GST is required";
    if (!RegExp(
        r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z][1-9A-Z]Z[0-9A-Z]$')
        .hasMatch(v)) {
      return "Enter valid GST number";
    }
    return null;
  }

  String? _validateIFSC(String? v) {
    if (v == null || v.isEmpty) return "IFSC required";
    if (!RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$').hasMatch(v)) {
      return "Format: SBIN0001234";
    }
    return null;
  }

  String? _validateAccountNo(String? v) {
    if (v == null || v.isEmpty) return "Account number required";
    if (!RegExp(r'^[0-9]{9,18}$').hasMatch(v)) {
      return "Enter valid account number";
    }
    return null;
  }

  String? _validateName(String? v) {
    if (v == null || v.isEmpty) return "Required";
    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(v)) {
      return "Only alphabets allowed";
    }
    return null;
  }

  /* ================= IMAGE PICKER ================= */

  Future<void> _pickImage(Function(File) onPicked) async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Camera"),
              onTap: () async {
                Navigator.pop(context);
                final img =
                await picker.pickImage(source: ImageSource.camera);
                if (img != null) onPicked(File(img.path));
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text("Gallery"),
              onTap: () async {
                Navigator.pop(context);
                final img =
                await picker.pickImage(source: ImageSource.gallery);
                if (img != null) onPicked(File(img.path));
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        title: const Text("Vendor Activation"),
        backgroundColor: primary,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(w * 0.05),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _StepCircle(text: "1", active: false, color: primary),
                  const _StepLine(),
                  _StepCircle(text: "2", active: true, color: primary),
                ],
              ),

              const SizedBox(height: 28),

              _section("Identity Details"),
              _input(
                aadhaarCtrl,
                "Aadhaar Number",
                Icons.credit_card,
                primary,
                keyboard: TextInputType.number,
                maxLength: 12,
                formatters: [FilteringTextInputFormatter.digitsOnly],
                validator: _validateAadhaar,
              ),
              _input(
                panCtrl,
                "PAN Number",
                Icons.badge,
                primary,
                maxLength: 10,
                formatters: [
                  FilteringTextInputFormatter.allow(RegExp('[A-Za-z0-9]')),
                  UpperCaseTextFormatter(),
                ],
                validator: _validatePAN,
              ),
              _input(
                gstCtrl,
                "GST Number",
                Icons.receipt,
                primary,
                maxLength: 15,
                formatters: [
                  FilteringTextInputFormatter.allow(RegExp('[A-Za-z0-9]')),
                  UpperCaseTextFormatter(),
                ],
                validator: _validateGST,
              ),

              _section("Bank Details"),
              _input(
                accHolderCtrl,
                "Account Holder Name",
                Icons.person,
                primary,
                validator: _validateName,
              ),
              _input(
                accNoCtrl,
                "Account Number",
                Icons.account_balance,
                primary,
                keyboard: TextInputType.number,
                maxLength: 18,
                formatters: [FilteringTextInputFormatter.digitsOnly],
                validator: _validateAccountNo,
              ),
              _input(
                ifscCtrl,
                "IFSC Code",
                Icons.code,
                primary,
                maxLength: 11,
                formatters: [
                  FilteringTextInputFormatter.allow(RegExp('[A-Za-z0-9]')),
                  UpperCaseTextFormatter(),
                ],
                validator: _validateIFSC,
              ),
              _input(
                bankNameCtrl,
                "Bank Name",
                Icons.account_balance,
                primary,
                validator: _validateName,
              ),

              _section("Upload Documents"),
              _docTile(w, "Aadhaar Document", aadhaarDoc, primary,
                      () => _pickImage((f) => setState(() => aadhaarDoc = f))),
              _docTile(w, "PAN Document", panDoc, primary,
                      () => _pickImage((f) => setState(() => panDoc = f))),
              _docTile(w, "GST Document", gstDoc, primary,
                      () => _pickImage((f) => setState(() => gstDoc = f))),
              _docTile(w, "IFSC / Bank Proof", ifscDoc, primary,
                      () => _pickImage((f) => setState(() => ifscDoc = f))),
              _docTile(w, "Shop Image", shopImg, primary,
                      () => _pickImage((f) => setState(() => shopImg = f))),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (aadhaarDoc == null ||
                          panDoc == null ||
                          gstDoc == null ||
                          ifscDoc == null ||
                          shopImg == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                            Text("Please upload all required documents"),
                          ),
                        );
                        return;
                      }

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const VendorMobileScreen(),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Submit & Continue",
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

  Widget _section(String text) => Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 20, bottom: 12),
    child: Text(text,
        style:
        const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
  );

  Widget _input(
      TextEditingController ctrl,
      String label,
      IconData icon,
      Color primary, {
        TextInputType keyboard = TextInputType.text,
        String? Function(String?)? validator,
        List<TextInputFormatter>? formatters,
        int? maxLength,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: ctrl,
        keyboardType: keyboard,
        validator: validator,
        inputFormatters: formatters,
        maxLength: maxLength,
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

  Widget _docTile(
      double w, String title, File? file, Color primary, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border:
        Border.all(color: file != null ? primary : Colors.grey.shade300),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          file != null ? Icons.check_circle : Icons.upload_file,
          color: file != null ? primary : Colors.grey,
        ),
        title: Text(title),
        subtitle: Text(
          file != null ? "Uploaded successfully" : "Tap to upload",
          style: TextStyle(color: file != null ? primary : Colors.grey),
        ),
        trailing: file != null
            ? Image.file(file,
            width: w * 0.12, height: w * 0.12, fit: BoxFit.cover)
            : const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(text: newValue.text.toUpperCase());
  }
}

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
