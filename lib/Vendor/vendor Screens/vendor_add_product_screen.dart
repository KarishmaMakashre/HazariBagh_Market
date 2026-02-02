import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../VendorProvider/vendor_store_provider.dart';
import '../VendorProvider/category_provider.dart';
import 'vendor_store_list_screen.dart';

class VendorAddStoreScreen extends StatefulWidget {
  const VendorAddStoreScreen({super.key});

  @override
  State<VendorAddStoreScreen> createState() => _VendorAddStoreScreenState();
}

class _VendorAddStoreScreenState extends State<VendorAddStoreScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final descController = TextEditingController();
  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final landmarkController = TextEditingController();
  final pincodeController = TextEditingController();
  final latController = TextEditingController();
  final lngController = TextEditingController();
  final openController = TextEditingController();
  final closeController = TextEditingController();


  //fashion store
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final mrpController = TextEditingController();
  final genderController = TextEditingController();
  final subCategoryController = TextEditingController();
  final sizesController = TextEditingController();
  final colorsController = TextEditingController();
  final clothSizeController = TextEditingController();
  final pantSizeController = TextEditingController();
  final shoeSizeController = TextEditingController();

  File? fashionImage;


  String? selectedCategory;

  File? storeImage;
  File? shopLicense;
  File? fssaiFile;

  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<CategoryProvider>().getAllCategories();
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    streetController.dispose();
    cityController.dispose();
    stateController.dispose();
    landmarkController.dispose();
    pincodeController.dispose();
    latController.dispose();
    lngController.dispose();
    openController.dispose();
    closeController.dispose();
    super.dispose();
  }

  Future<void> pickImage(Function(File) onPicked) async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      onPicked(File(picked.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final storeProvider = context.watch<VendorStoreProvider>();
    final categoryProvider = context.watch<CategoryProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Create Store")),
      body: categoryProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _input(nameController, "Store Name"),

              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration:
                const InputDecoration(labelText: "Category"),
                items: categoryProvider.categoryList
                    .map<DropdownMenuItem<String>>(
                      (c) => DropdownMenuItem(
                    value: c['_id'].toString(),
                    child: Text(c['name']),
                  ),
                )
                    .toList(),
                onChanged: (v) =>
                    setState(() => selectedCategory = v),
                validator: (v) =>
                v == null ? "Select category" : null,
              ),

              _input(descController, "Description"),
              _input(streetController, "Street"),
              _input(cityController, "City"),
              _input(stateController, "State"),
              _input(landmarkController, "Landmark"),
              _input(pincodeController, "Pincode"),
              _input(latController, "Latitude"),
              _input(lngController, "Longitude"),
              _input(openController, "Open Time"),
              _input(closeController, "Close Time"),

              _file(
                "Store Image",
                storeImage,
                    () => pickImage(
                      (f) => setState(() => storeImage = f),
                ),
              ),
              _file(
                "Shop License",
                shopLicense,
                    () => pickImage(
                      (f) => setState(() => shopLicense = f),
                ),
              ),
              _file(
                "FSSAI",
                fssaiFile,
                    () => pickImage(
                      (f) => setState(() => fssaiFile = f),
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: storeProvider.isLoading
                    ? null
                    : () async {
                  if (!_formKey.currentState!.validate()) return;

                  if (storeImage == null ||
                      shopLicense == null ||
                      fssaiFile == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("All files required"),
                      ),
                    );
                    return;
                  }

                  final success = await context
                      .read<VendorStoreProvider>()
                      .createStore(
                    name: nameController.text,
                    category: selectedCategory!,
                    description: descController.text,
                    street: streetController.text,
                    city: cityController.text,
                    state: stateController.text,
                    landmark: landmarkController.text,
                    pincode: pincodeController.text,
                    lat: latController.text,
                    lng: lngController.text,
                    openTime: openController.text,
                    closeTime: closeController.text,
                    storeImage: storeImage!,
                    shopLicense: shopLicense!,
                    fssaiFile: fssaiFile!,
                  );

                  if (mounted) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                        const VendorStoreListScreen(),
                      ),
                    );
                  }
                },
                child: storeProvider.isLoading
                    ? const CircularProgressIndicator(
                  color: Colors.white,
                )
                    : const Text("Create Store"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _input(TextEditingController c, String label) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: TextFormField(
      controller: c,
      decoration: InputDecoration(labelText: label),
      validator: (v) => v == null || v.isEmpty ? "Required" : null,
    ),
  );

  Widget _file(String title, File? file, VoidCallback onTap) => ListTile(
    title: Text(title),
    subtitle: Text(
      file?.path.split('/').last ?? "No file selected",
      style: TextStyle(
        color: file == null ? Colors.red : Colors.green,
      ),
    ),
    trailing: IconButton(
      icon: const Icon(Icons.upload),
      onPressed: onTap,
    ),
  );
}
