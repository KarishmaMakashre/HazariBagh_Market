import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../VendorProvider/food_store_provider.dart';
import 'vendor_food_store_list_screen.dart';

class VendorFoodStoreScreen extends StatefulWidget {
  final String storeId;
  const VendorFoodStoreScreen({super.key, required this.storeId});

  @override
  State<VendorFoodStoreScreen> createState() => _VendorFoodStoreScreenState();
}

class _VendorFoodStoreScreenState extends State<VendorFoodStoreScreen> {
  final _formKey = GlobalKey<FormState>();

  // BASIC INFO
  final storeName = TextEditingController();
  final type = TextEditingController(text: "CAFE");
  final description = TextEditingController();

  // ADDRESS
  final line1 = TextEditingController();
  final area = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final pincode = TextEditingController();
  final country = TextEditingController(text: "India");

  // GEO
  final lat = TextEditingController();
  final lng = TextEditingController();
  final radius = TextEditingController();

  // OTHER
  final foodType = TextEditingController(text: "VEG");

  bool isOpen = true;
  List<File> images = [];

  // IMAGE PICKER
  Future<void> pickImages() async {
    final picker = ImagePicker();
    final picked = await picker.pickMultiImage();
    if (picked.isNotEmpty) {
      setState(() {
        images = picked.map((e) => File(e.path)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FoodStoreProvider>();
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        title: const Text("Create Food Store"),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // BASIC INFO
              field(storeName, "Store Name"),
              field(type, "Type (CAFE / RESTAURANT)"),
              field(description, "Description"),

              const Divider(),

              // ADDRESS
              field(line1, "Address Line"),
              field(area, "Area"),
              field(city, "City"),
              field(state, "State"),
              field(pincode, "Pincode"),
              field(country, "Country"),

              const Divider(),

              // GEO
              field(lat, "Latitude"),
              field(lng, "Longitude"),
              field(radius, "Delivery Radius (Km)"),

              const Divider(),

              // FOOD TYPE
              field(foodType, "Food Type (VEG / NON-VEG)"),

              // IS OPEN SWITCH
              SwitchListTile(
                title: const Text("Store Open"),
                value: isOpen,
                onChanged: (v) => setState(() => isOpen = v),
              ),

              const SizedBox(height: 10),

              // IMAGES PICKER
              ElevatedButton.icon(
                onPressed: pickImages,
                icon: const Icon(Icons.image),
                label: Text("Pick Images (${images.length})"),
              ),

              const SizedBox(height: 25),

              // SUBMIT BUTTON
              provider.isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text("CREATE STORE"),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final success =
                      await provider.createFoodStore(
                        storeName: storeName.text,
                        type: type.text,
                        description: description.text,
                        line1: line1.text,
                        area: area.text,
                        city: city.text,
                        state: state.text,
                        pincode: pincode.text,
                        country: country.text,
                        lat: lat.text,
                        lng: lng.text,
                        deliveryRadiusKm: radius.text,
                        isOpen: isOpen,
                        foodType: [
                          foodType.text
                        ], // ✅ List<String>
                        category:
                        "6980867733f025d91e016a51", // fixed sub-category
                        images: images,
                      );

                      if (success && mounted) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const VendorFoodStoreListScreen(),
                          ),
                        );
                      }
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

  // REUSABLE TEXT FIELD
  Widget field(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        validator: (v) => v == null || v.isEmpty ? "Required" : null,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}