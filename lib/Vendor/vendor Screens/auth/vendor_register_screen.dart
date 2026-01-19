import 'dart:typed_data';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/Vendor/vendor%20Screens/vendor_dashboard_home_screen.dart';
import 'package:image_picker/image_picker.dart';
import '../../../colors/AppColors.dart';

class VendorRegisterScreen  extends StatefulWidget {
  const VendorRegisterScreen({super.key});

  @override
  State<VendorRegisterScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<VendorRegisterScreen> {
  bool _isPersonalStep = true;
  bool _isAddressStep = false;
  bool _isBankStep = false;
  bool _isDocumentStep = false;

  /// PERSONAL
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  /// STORE
  final _storeNameController = TextEditingController();
  final _storeDescController = TextEditingController();
  String? _selectedCategory;
  String? _selectedStoreType;
  bool _agreedToTerms = false;

  /// ADDRESS
  final _streetController = TextEditingController();
  final _landmarkController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();

  /// BANK
  final _accountHolderController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _ifscController = TextEditingController();
  final _bankNameController = TextEditingController();

  /// DOCUMENTS
  Uint8List? aadharDoc;
  Uint8List? panDoc;
  Uint8List? gstDoc;
  Uint8List? shopLicense;
  Uint8List? fssaiDoc;

  final ImagePicker _picker = ImagePicker();
  Uint8List? profileImage;
  Uint8List? shopImage;

  final List<String> _categories = [
    'Grocery',
    'Restaurant',
    'Clothing',
    'Electronics',
    'Other'
  ];

  final List<String> _storeTypes = ['Individual', 'Franchise'];

  /// IMAGE PICKER (PROFILE / SHOP)
  Future<void> _showImagePicker(bool isProfile) async {
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text("Camera"),
            onTap: () async {
              final image =
              await _picker.pickImage(source: ImageSource.camera);
              if (image != null) {
                final bytes = await image.readAsBytes();
                setState(() =>
                isProfile ? profileImage = bytes : shopImage = bytes);
              }
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo),
            title: const Text("Gallery"),
            onTap: () async {
              final image =
              await _picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                final bytes = await image.readAsBytes();
                setState(() =>
                isProfile ? profileImage = bytes : shopImage = bytes);
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  /// DOC PICKER
  Future<void> _pickDoc(Function(Uint8List) onPicked) async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() => onPicked(bytes));
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final padding = width * 0.05;

    return Scaffold(
      body: Column(
        children: [
          /// HEADER (UNCHANGED)
          Container(
            height: height * 0.22,
            width: double.infinity,
            padding: EdgeInsets.only(left: padding, top: height * 0.06),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  if (_isDocumentStep) {
                    setState(() {
                      _isDocumentStep = false;
                      _isBankStep = true;
                    });
                  } else if (_isBankStep) {
                    setState(() {
                      _isBankStep = false;
                      _isAddressStep = true;
                    });
                  } else if (_isAddressStep) {
                    setState(() {
                      _isAddressStep = false;
                      _isPersonalStep = true;
                    });
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: width * 0.06,
                  ),
                ),
              ),
            ),
          ),

          /// BODY
          Expanded(
            child: Container(
              transform: Matrix4.translationValues(0, -height * 0.09, 0),
              padding: EdgeInsets.all(padding),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _isPersonalStep
                          ? "Personal Details"
                          : _isAddressStep
                          ? "Address Details"
                          : _isBankStep
                          ? "Bank Details"
                          : _isDocumentStep
                          ? "Document Upload"
                          : "Store Details",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),


                    /// 🔹 TOP IMAGE
                    Center(
                      child: Image.asset(
                        'assets/images/Gemini_Generated_Image_r94uoer94uoer94u-removebg-preview.png',
                        height: height * 0.16,
                        fit: BoxFit.contain,
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// 🔹 PROFILE IMAGE WITH CAMERA
                    if (_isPersonalStep)
                      Center(
                        child: GestureDetector(
                          onTap: () => _showImagePicker(true),
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                radius: width * 0.12,
                                backgroundColor: Colors.grey.shade300,
                                backgroundImage: profileImage != null
                                    ? MemoryImage(profileImage!)
                                    : null,
                                child: profileImage == null
                                    ? Icon(
                                  Icons.person,
                                  size: width * 0.12,
                                  color: Colors.white,
                                )
                                    : null,
                              ),

                              /// CAMERA ICON
                              Positioned(
                                bottom: 4,
                                right: 4,
                                child: Container(
                                  height: width * 0.08,
                                  width: width * 0.08,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.15),
                                        blurRadius: 6,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    size: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    const SizedBox(height: 25),

                    /// 🔹 PERSONAL STEP
                    if (_isPersonalStep) ...[
                      _inputField(Icons.person, "Full Name", _fullNameController),
                      _gap(),
                      _inputField(Icons.email, "Email", _emailController),
                      _gap(),
                      _inputField(
                        Icons.phone,
                        "Phone",
                        _phoneController,
                        keyboard: TextInputType.phone,
                        maxLength: 10,
                      ),
                    ],

                    /// 🔹 STORE STEP
                    if (!_isPersonalStep &&
                        !_isAddressStep &&
                        !_isBankStep &&
                        !_isDocumentStep) ...[
                      _inputField(Icons.store, "Store Name", _storeNameController),
                      _gap(),
                      _dropdown(
                        "Category",
                        _selectedCategory,
                        _categories,
                            (v) => setState(() => _selectedCategory = v),
                      ),
                      _gap(),
                      _dropdown(
                        "Store Type",
                        _selectedStoreType,
                        _storeTypes,
                            (v) => setState(() => _selectedStoreType = v),
                      ),
                      _gap(),
                      _inputField(Icons.description, "Description", _storeDescController),
                      _gap(),
                      GestureDetector(
                        onTap: () => _showImagePicker(false),
                        child: _imageBox(shopImage, "Upload Shop Image"),
                      ),
                    ],

                    /// 🔹 ADDRESS STEP
                    if (_isAddressStep) ...[
                      _inputField(Icons.location_on, "Street", _streetController),
                      _gap(),
                      _inputField(Icons.location_city, "City", _cityController),
                      _gap(),
                      _inputField(Icons.map, "State", _stateController),
                      _gap(),
                      _inputField(
                        Icons.pin,
                        "Pincode",
                        _pincodeController,
                        keyboard: TextInputType.number,
                      ),
                    ],

                    /// 🔹 BANK STEP
                    if (_isBankStep) ...[
                      _inputField(
                          Icons.person, "Account Holder Name", _accountHolderController),
                      _gap(),
                      _inputField(
                          Icons.numbers, "Account Number", _accountNumberController),
                      _gap(),
                      _inputField(Icons.code, "IFSC Code", _ifscController),
                      _gap(),
                      _inputField(
                          Icons.account_balance, "Bank Name", _bankNameController),
                    ],

                    /// 🔹 DOCUMENT STEP
                    if (_isDocumentStep) ...[
                      _docTile("Aadhar", aadharDoc,
                              () => _pickDoc((v) => aadharDoc = v)),
                      _gap(),
                      _docTile("PAN", panDoc, () => _pickDoc((v) => panDoc = v)),
                      _gap(),
                      _docTile("GST", gstDoc, () => _pickDoc((v) => gstDoc = v)),
                      _gap(),
                      _docTile("Shop License", shopLicense,
                              () => _pickDoc((v) => shopLicense = v)),
                      _gap(),
                      _docTile(
                          "FSSAI", fssaiDoc, () => _pickDoc((v) => fssaiDoc = v)),
                    ],

                    const SizedBox(height: 30),

                    /// 🔹 BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: _handleButton,
                        child: Text(
                          _isDocumentStep ? "REGISTER" : "NEXT",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// FLOW
  void _handleButton() {
    if (_isPersonalStep) {
      setState(() => _isPersonalStep = false);
    } else if (!_isAddressStep &&
        !_isBankStep &&
        !_isDocumentStep) {
      setState(() => _isAddressStep = true);
    } else if (_isAddressStep) {
      setState(() {
        _isAddressStep = false;
        _isBankStep = true;
      });
    } else if (_isBankStep) {
      setState(() {
        _isBankStep = false;
        _isDocumentStep = true;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const VendorDashboardHomeScreen()),
      );
    }
  }

  /// HELPERS
  Widget _docTile(String title, Uint8List? file, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.primary),
            borderRadius: BorderRadius.circular(14)),
        child: Center(
          child: Text(file == null ? "Upload $title" : "$title Uploaded ✔"),
        ),
      ),
    );
  }

  static Widget _inputField(IconData icon, String hint,
      TextEditingController controller,
      {TextInputType keyboard = TextInputType.text, int? maxLength}) {
    return TextField(
      controller: controller,
      keyboardType: keyboard,
      maxLength: maxLength,
      decoration: InputDecoration(
        counterText: "",
        prefixIcon: Icon(icon, color: AppColors.primary),
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF6F6F6),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none),
      ),
    );
  }

  Widget _dropdown(String hint, String? value, List<String> items,
      ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      hint: Text(hint),
      items:
      items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: onChanged,
    );
  }

  Widget _imageBox(Uint8List? image, String text) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary),
          borderRadius: BorderRadius.circular(18)),
      child: image == null
          ? Center(child: Text(text))
          : Image.memory(image, fit: BoxFit.cover),
    );
  }

  Widget _gap() => const SizedBox(height: 15);
}
