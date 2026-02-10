import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/Vendor/vendor_screens/vendor_dashboard_home_screen.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../VendorProvider/category_provider.dart';
import '../VendorAllCreateCategorys/vendor_model/category_model.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm>
    with SingleTickerProviderStateMixin {
  /// 🔁 Animation (kept as-is, just image removed)
  late AnimationController _bikeController;
  late Animation<Offset> _bikeMove;

  /// 📦 Hive
  late Box box;

  int step = 1;
  Category? selectedCategory;

  /// ================= STEP 1 =================
  final nameController = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();

  /// ================= BUSINESS =================
  final storeName = TextEditingController();
  final description = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();

  final aadharNumber = TextEditingController();
  final panNumber = TextEditingController();
  final gstNumber = TextEditingController();

  final accountHolderName = TextEditingController();
  final accountNumber = TextEditingController();
  final ifsc = TextEditingController();
  final bankName = TextEditingController();

  /// ================= JOB =================
  final jobTitle = TextEditingController();
  final subCategory = TextEditingController();
  final jobDescription = TextEditingController();
  final requiredSkills = TextEditingController();
  final openings = TextEditingController();
  final salaryMin = TextEditingController();
  final salaryMax = TextEditingController();
  final experienceMin = TextEditingController();
  final experienceMax = TextEditingController();

  /// ================= PROPERTY =================
  final propertyName = TextEditingController();
  final propertyType = TextEditingController();
  final priceType = TextEditingController();
  final priceAmount = TextEditingController();
  final address = TextEditingController();
  final propertyCity = TextEditingController();
  final propertyState = TextEditingController();
  final sizeValue = TextEditingController();
  final bedrooms = TextEditingController();
  final bathrooms = TextEditingController();
  final kitchens = TextEditingController();
  final balconies = TextEditingController();
  final floors = TextEditingController();
  final amenities = TextEditingController();
  final propertyDescription = TextEditingController();

  /// ================= INIT =================
  @override
  void initState() {
    super.initState();

    box = Hive.box('registerBox');
    loadDraft();

    _bikeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _bikeMove =
        Tween<Offset>(
          begin: const Offset(0, 0.15),
          end: const Offset(0, -0.05),
        ).animate(
          CurvedAnimation(parent: _bikeController, curve: Curves.easeInOut),
        );

    _bikeController.repeat(reverse: true);
  }

  /// ================= HIVE =================
  void loadDraft() {
    step = box.get("step", defaultValue: 1);
    nameController.text = box.get("name", defaultValue: "");
    email.text = box.get("email", defaultValue: "");
    phone.text = box.get("phone", defaultValue: "");
  }

  void saveDraft() {
    box.putAll({
      "step": step,
      "name": nameController.text,
      "email": email.text,
      "phone": phone.text,
      "category": selectedCategory?.name,
    });
  }

  /// ================= INPUT =================
  Widget input(
      String label,
      TextEditingController c, {
        TextInputType type = TextInputType.text,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: c,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  /// ================= STEP 2 =================
  Widget buildStep2() {
    final name = selectedCategory?.name.toLowerCase() ?? "";

    if (name.contains("job")) return jobForm();
    if (name.contains("property")) return propertyForm();

    return businessForm();
  }

  /// ================= BUSINESS =================
  Widget businessForm() {
    return Column(
      children: [
        input("Store Name", storeName),
        input("Description", description),
        input("City", city),
        input("State", state),
        input("Aadhar Number", aadharNumber),
        input("PAN Number", panNumber),
        input("GST Number", gstNumber),
        input("Account Holder Name", accountHolderName),
        input("Account Number", accountNumber),
        input("IFSC", ifsc),
        input("Bank Name", bankName),
      ],
    );
  }

  /// ================= JOB =================
  Widget jobForm() {
    return Column(
      children: [
        input("Job Title", jobTitle),
        input("Sub Category", subCategory),
        input("Job Description", jobDescription),
        input("Required Skills", requiredSkills),
        input("Openings", openings, type: TextInputType.number),
        input("Salary Min", salaryMin, type: TextInputType.number),
        input("Salary Max", salaryMax, type: TextInputType.number),
        input("Experience Min", experienceMin),
        input("Experience Max", experienceMax),
        input("City", city),
        input("State", state),
        uploadButton("Upload Profile Image"),
        uploadButton("Upload Aadhar"),
        uploadButton("Upload PAN"),
        uploadButton("Upload GST"),
      ],
    );
  }

  /// ================= PROPERTY =================
  Widget propertyForm() {
    return Column(
      children: [
        input("Property Name", propertyName),
        input("Property Type", propertyType),
        input("Price Type", priceType),
        input("Price Amount", priceAmount),
        input("Address", address),
        input("City", propertyCity),
        input("State", propertyState),
        input("Size", sizeValue),
        input("Bedrooms", bedrooms),
        input("Bathrooms", bathrooms),
        input("Kitchens", kitchens),
        input("Balconies", balconies),
        input("Floors", floors),
        input("Amenities", amenities),
        input("Description", propertyDescription),
        uploadButton("Upload Property Images"),
      ],
    );
  }

  /// ================= UI =================
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VendorCategoryProvider>();
    final primary = Theme.of(context).colorScheme.primary;

    return WillPopScope(
      onWillPop: () async {
        if (step == 2) {
          setState(() => step = 1);
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Register", style: TextStyle(color: Colors.white)),
          backgroundColor: primary,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Column(
          children: [
            /// 📋 FORM (image removed only)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: step == 1
                    ? Column(
                  children: [
                    input("Name", nameController),
                    input("Email", email),
                    input("Phone", phone, type: TextInputType.phone),
                    DropdownButtonFormField<Category>(
                      value: selectedCategory,
                      decoration: const InputDecoration(
                        labelText: "Category",
                      ),
                      items: provider.categories
                          .map(
                            (c) => DropdownMenuItem(
                          value: c,
                          child: Text(c.name),
                        ),
                      )
                          .toList(),
                      onChanged: (c) =>
                          setState(() => selectedCategory = c),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: selectedCategory == null
                          ? null
                          : () {
                        setState(() => step = 2);
                        saveDraft();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.primary,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 52),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        "Next",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                )
                    : SingleChildScrollView(
                  child: Column(
                    children: [
                      buildStep2(),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          await box.clear();

                          // HomePage par navigate
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const VendorDashboardHomeScreen(),
                            ),
                                (route) => false,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Submitted Successfully"),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 52),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
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
      ),
    );
  }

  Widget uploadButton(String label) {
    final primary = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: OutlinedButton.icon(
        onPressed: () {
          // image picker logic later
        },
        icon: Icon(Icons.upload_file, color: primary),
        label: Text(
          label,
          style: TextStyle(color: primary, fontWeight: FontWeight.w600),
        ),
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 52),
          side: BorderSide(color: primary, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }

  /// ================= DISPOSE =================
  @override
  void dispose() {
    _bikeController.dispose();

    nameController.dispose();
    email.dispose();
    phone.dispose();
    storeName.dispose();
    description.dispose();
    city.dispose();
    state.dispose();
    aadharNumber.dispose();
    panNumber.dispose();
    gstNumber.dispose();
    accountHolderName.dispose();
    accountNumber.dispose();
    ifsc.dispose();
    bankName.dispose();

    super.dispose();
  }
}
