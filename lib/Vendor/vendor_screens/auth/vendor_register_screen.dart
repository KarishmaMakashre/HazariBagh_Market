import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/Vendor/vendor_screens/vendor_home_page.dart';
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
  late AnimationController _bikeController;
  late Animation<Offset> _bikeMove;

  late Box box;

  int step = 1;
  Category? selectedCategory;

  final nameController = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();

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

  final jobTitle = TextEditingController();
  final subCategory = TextEditingController();
  final jobDescription = TextEditingController();
  final requiredSkills = TextEditingController();
  final openings = TextEditingController();
  final salaryMin = TextEditingController();
  final salaryMax = TextEditingController();
  final experienceMin = TextEditingController();
  final experienceMax = TextEditingController();

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

  @override
  void initState() {
    super.initState();

    box = Hive.box('registerBox');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VendorCategoryProvider>().fetchCategories();
    });

    _bikeController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));

    _bikeMove = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _bikeController, curve: Curves.easeOut));

    _bikeController.forward();
  }

  Widget input(String label, TextEditingController c,
      {TextInputType type = TextInputType.text}) {
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

  Widget buildStep2() {
    final name = selectedCategory?.name.toLowerCase() ?? "";
    if (name.contains("job")) return jobForm();
    if (name.contains("property")) return propertyForm();
    return businessForm();
  }

  Widget businessForm() {
    return Column(children: [
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
    ]);
  }

  Widget jobForm() {
    return Column(children: [
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
    ]);
  }

  Widget propertyForm() {
    return Column(children: [
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
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VendorCategoryProvider>();
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
    );
  }

  @override
  void dispose() {
    _bikeController.dispose();
    super.dispose();
  }
}