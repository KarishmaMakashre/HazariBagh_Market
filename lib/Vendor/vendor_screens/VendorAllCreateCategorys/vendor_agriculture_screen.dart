import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/agriculture_model.dart';
import 'Vendor_Agriculture_Detail_Screen.dart';

class VendorAgricultureScreen extends StatefulWidget {
  final String storeId;
  const VendorAgricultureScreen({super.key, required this.storeId});

  @override
  State<VendorAgricultureScreen> createState() =>
      _VendorAgricultureScreenState();
}

class _VendorAgricultureScreenState extends State<VendorAgricultureScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  // -------- FORM VARIABLES (MATCH MODEL TYPES) --------
  String name = "";
  String description = "";
  String listingType = "";

  double price = 0; // double?
  int quantityAvailable = 0;

  String serviceType = "";
  double charge = 0; // ✅ double? (FIXED)
  String chargeType = "";
  String availability = "";
  String serviceMode = "OnField";

  String district = "";
  String state = "";
  String pincode = "";
  String country = "india";

  double lat = 23.0; // double
  double lng = 76.0; // double

  List<String> requiredDocuments = [];
  List<File> images = [];

  // -------- IMAGE PICKER --------
  Future<void> pickImages() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        images = pickedFiles.map((e) => File(e.path)).toList();
      });
    }
  }

  // -------- UI --------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Agriculture")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: "Name"),
                  onSaved: (val) => name = val ?? "",
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Description"),
                  onSaved: (val) => description = val ?? "",
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Listing Type"),
                  onSaved: (val) => listingType = val ?? "",
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Price"),
                  keyboardType: TextInputType.number,
                  onSaved: (val) =>
                  price = double.tryParse(val ?? "0") ?? 0,
                ),
                TextFormField(
                  decoration:
                  const InputDecoration(labelText: "Quantity Available"),
                  keyboardType: TextInputType.number,
                  onSaved: (val) =>
                  quantityAvailable = int.tryParse(val ?? "0") ?? 0,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Service Type"),
                  onSaved: (val) => serviceType = val ?? "",
                ),

                // 🔥 FIXED: charge parsed as double
                TextFormField(
                  decoration: const InputDecoration(labelText: "Charge"),
                  keyboardType: TextInputType.number,
                  onSaved: (val) =>
                  charge = double.tryParse(val ?? "0") ?? 0,
                ),

                TextFormField(
                  decoration: const InputDecoration(labelText: "Charge Type"),
                  onSaved: (val) => chargeType = val ?? "",
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Availability"),
                  onSaved: (val) => availability = val ?? "",
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "District"),
                  onSaved: (val) => district = val ?? "",
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "State"),
                  onSaved: (val) => state = val ?? "",
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Pincode"),
                  onSaved: (val) => pincode = val ?? "",
                ),
                TextFormField(
                  decoration:
                  const InputDecoration(labelText: "Required Documents"),
                  onSaved: (val) =>
                  requiredDocuments = val?.split(",") ?? [],
                ),
                const SizedBox(height: 12),

                ElevatedButton(
                  onPressed: pickImages,
                  child: const Text("Pick Images"),
                ),
                const SizedBox(height: 10),

                images.isNotEmpty
                    ? Wrap(
                  spacing: 10,
                  children: images
                      .map((e) =>
                      Image.file(e, width: 80, height: 80))
                      .toList(),
                )
                    : const Text("No images selected"),

                const SizedBox(height: 20),

                // -------- SUBMIT --------
                ElevatedButton(
                  onPressed: () {
                    _formKey.currentState?.save();

                    final agriculture = Agriculture(
                      id: "696f5568eaf0c682afc1a931",
                      name: name,
                      description: description,
                      listingType: listingType,
                      price: price,
                      quantityAvailable: quantityAvailable,
                      serviceType: serviceType,
                      charge: charge, // ✅ double?
                      chargeType: chargeType,
                      availability: availability,
                      serviceMode: serviceMode,
                      images: images.map((e) => e.path).toList(),
                      requiredDocuments: requiredDocuments,
                      district: district,
                      state: state,
                      pincode: pincode,
                      country: country,
                      lat: lat,
                      lng: lng,
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            VendorAgricultureDetailScreen(
                                agriculture: agriculture),
                      ),
                    );
                  },
                  child: const Text("Submit"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}