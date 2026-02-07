import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../VendorProvider/vendor_Property_Provider.dart';


class PropertyCreateScreen extends StatefulWidget {
  final String storeId;
  const PropertyCreateScreen({super.key, required this.storeId});

  @override
  State<PropertyCreateScreen> createState() => _PropertyCreateScreenState();
}

class _PropertyCreateScreenState extends State<PropertyCreateScreen> {
  final _formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final subCategoryId = TextEditingController();
  final propertyType = TextEditingController();
  final priceType = TextEditingController();
  final priceAmount = TextEditingController();
  final address = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final latitude = TextEditingController();
  final longitude = TextEditingController();
  final sizeValue = TextEditingController();
  final sizeUnit = TextEditingController();
  final bedrooms = TextEditingController();
  final bathrooms = TextEditingController();
  final kitchens = TextEditingController();
  final balconies = TextEditingController();
  final floors = TextEditingController();
  final furnishing = TextEditingController();
  final description = TextEditingController();
  final amenities = TextEditingController();

  List<File> images = [];

  Future<void> pickImages() async {
    final picked = await ImagePicker().pickMultiImage();
    if (picked.isNotEmpty) {
      setState(() => images = picked.map((e) => File(e.path)).toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VendorPropertyProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Properties'),
        backgroundColor: Theme.of(context).primaryColor, // primary color background
        foregroundColor: Colors.white, // makes title & icons white
        // OR, for more control:
        // iconTheme: IconThemeData(color: Colors.white),
        // titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              field(name, "Property Name"),
              field(subCategoryId, "Sub Category ID"),
              field(propertyType, "Property Type"),
              field(priceType, "Price Type"),
              field(priceAmount, "Price Amount"),
              field(address, "Address"),
              field(city, "City"),
              field(state, "State"),
              field(latitude, "Latitude"),
              field(longitude, "Longitude"),
              field(sizeValue, "Size Value"),
              field(sizeUnit, "Size Unit"),
              field(bedrooms, "Bedrooms"),
              field(bathrooms, "Bathrooms"),
              field(kitchens, "Kitchens"),
              field(balconies, "Balconies"),
              field(floors, "Floors"),
              field(furnishing, "Furnishing"),
              field(description, "Description"),
              field(amenities, "Amenities"),

              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: pickImages,
                icon: const Icon(Icons.image),
                label: Text("Pick Images (${images.length})"),
              ),
              const SizedBox(height: 20),

              provider.isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text("Add Property"),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final success = await provider.addProperty(
                        name: name.text,
                        subCategoryId: subCategoryId.text,
                        propertyType: propertyType.text,
                        priceType: priceType.text,
                        priceAmount: priceAmount.text,
                        address: address.text,
                        city: city.text,
                        state: state.text,
                        latitude: double.tryParse(latitude.text) ?? 0,
                        longitude: double.tryParse(longitude.text) ?? 0,
                        sizeValue: double.tryParse(sizeValue.text) ?? 0,
                        sizeUnit: sizeUnit.text,
                        bedrooms: int.tryParse(bedrooms.text) ?? 0,
                        bathrooms: int.tryParse(bathrooms.text) ?? 0,
                        kitchens: int.tryParse(kitchens.text) ?? 0,
                        balconies: int.tryParse(balconies.text) ?? 0,
                        floors: int.tryParse(floors.text) ?? 0,
                        furnishing: furnishing.text,
                        description: description.text,
                        amenities: amenities.text,
                        images: images,
                      );

                      if (success && mounted) {
                        Navigator.pop(context);
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

  Widget field(TextEditingController c, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: c,
        validator: (v) => v == null || v.isEmpty ? "Required" : null,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
