import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../VendorProvider/govt_provider.dart';

class VendorGovermentServiceScreen extends StatefulWidget {
  final String storeId;

  const VendorGovermentServiceScreen({super.key, required this.storeId});

  @override
  State<VendorGovermentServiceScreen> createState() =>
      _VendorGovermentServiceScreenState();
}

class _VendorGovermentServiceScreenState
    extends State<VendorGovermentServiceScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final nameController = TextEditingController();
  final categoryIdController = TextEditingController(text: "696f1b2290912a157b5a05aa");
  final serviceTypeController = TextEditingController(text: "Government");
  final serviceModeController = TextEditingController(text: "Both");
  final allowApplyController = TextEditingController(text: "true");
  final allowVisitController = TextEditingController(text: "true");
  final line1Controller = TextEditingController();
  final areaController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController(text: "india");
  final pincodeController = TextEditingController();
  final latController = TextEditingController(text: "23");
  final lngController = TextEditingController(text: "76");
  final priceController = TextEditingController();
  final processingTimeController = TextEditingController(text: "4 -5 days");
  final documentsController = TextEditingController();

  // Images
  List<File> images = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    nameController.dispose();
    categoryIdController.dispose();
    serviceTypeController.dispose();
    serviceModeController.dispose();
    allowApplyController.dispose();
    allowVisitController.dispose();
    line1Controller.dispose();
    areaController.dispose();
    cityController.dispose();
    stateController.dispose();
    countryController.dispose();
    pincodeController.dispose();
    latController.dispose();
    lngController.dispose();
    priceController.dispose();
    processingTimeController.dispose();
    documentsController.dispose();
    super.dispose();
  }

  Future<void> pickImages() async {
    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        images = pickedFiles.map((e) => File(e.path)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GovtProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Add Government Service")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildField(nameController, "Service Name"),
              _buildField(line1Controller, "Address Line 1"),
              _buildField(areaController, "Area"),
              _buildField(cityController, "City"),
              _buildField(stateController, "State"),
              _buildField(countryController, "Country"),
              _buildField(pincodeController, "Pincode"),
              _buildField(latController, "Latitude"),
              _buildField(lngController, "Longitude"),
              _buildField(priceController, "Price Range"),
              _buildField(processingTimeController, "Processing Time"),
              _buildField(documentsController, "Required Documents"),
              _buildField(serviceModeController, "Service Mode"),
              _buildField(serviceTypeController, "Service Type"),
              _buildField(allowApplyController, "Allow Apply"),
              _buildField(allowVisitController, "Allow Visit"),

              const SizedBox(height: 12),

              ElevatedButton(
                onPressed: pickImages,
                child: const Text("Select Images"),
              ),
              const SizedBox(height: 8),
              if (images.isNotEmpty)
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: images
                      .map((img) => Image.file(
                    img,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ))
                      .toList(),
                ),

              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: provider.isLoading
                    ? null
                    : () async {
                  if (!_formKey.currentState!.validate()) return;

                  final fields = {
                    "name": nameController.text,
                    "categoryId": categoryIdController.text,
                    "serviceType": serviceTypeController.text,
                    "serviceMode": serviceModeController.text,
                    "allowApply": allowApplyController.text,
                    "allowVisit": allowVisitController.text,
                    "address[line1]": line1Controller.text,
                    "address[area]": areaController.text,
                    "address[city]": cityController.text,
                    "address[state]": stateController.text,
                    "address[country]": countryController.text,
                    "address[pincode]": pincodeController.text,
                    "geoLocation[lat]": latController.text,
                    "geoLocation[lng]": lngController.text,
                    "price": priceController.text,
                    "processingTimeDays": processingTimeController.text,
                    "requiredDocuments": documentsController.text,
                  };

                  final ok = await provider.createGovtService(
                    fields: fields,
                    images: images,
                  );

                  if (ok && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Service created successfully"),
                      ),
                    );
                  }
                },
                child: provider.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Create Service"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        validator: (v) => v == null || v.isEmpty ? "Required" : null,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
        ),
      ),
    );
  }
}
