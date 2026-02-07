import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../VendorProvider/education_provider.dart';
import 'education_detail_screen.dart';

class VendorEducationScreen extends StatefulWidget {
  final String storeId;
  const VendorEducationScreen({super.key, required this.storeId});

  @override
  State<VendorEducationScreen> createState() => _VendorEducationScreenState();
}

class _VendorEducationScreenState extends State<VendorEducationScreen> {
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();

  // Form fields
  String? name,
      type,
      description,
      mode,
      address,
      city,
      state,
      pincode,
      price,
      duration,
      schedule,
      ageGroup,
      phone,
      email,
      tags;
  File? imageFile;

  // Pick image from gallery
  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  // Submit form
  Future<void> submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    // Replace with your auth token
    final token = "YOUR_USER_TOKEN_HERE";

    final provider = Provider.of<EducationProvider>(context, listen: false);
    final success = await provider.createEducation(
      name: name!,
      type: type!,
      description: description!,
      mode: mode!,
      address: address!,
      city: city!,
      state: state!,
      pincode: pincode,
      price: price!,
      duration: duration!,
      schedule: schedule!,
      ageGroup: ageGroup!,
      phone: phone!,
      email: email!,
      tags: tags!,
      imageFile: imageFile,
      token: token,
    );

    if (success) {
      final newEducation = provider.educations.last;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => EducationDetailScreen(education: newEducation),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to create education")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Education")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              buildTextField("Course Name", (val) => name = val),
              buildTextField("Type", (val) => type = val),
              buildTextField("Description", (val) => description = val, maxLines: 3),
              buildTextField("Mode", (val) => mode = val),
              buildTextField("Address", (val) => address = val),
              buildTextField("City", (val) => city = val),
              buildTextField("State", (val) => state = val),
              buildTextField("Pincode", (val) => pincode = val, keyboard: TextInputType.number),
              buildTextField("Price", (val) => price = val, keyboard: TextInputType.number),
              buildTextField("Duration", (val) => duration = val),
              buildTextField("Schedule", (val) => schedule = val),
              buildTextField("Age Group", (val) => ageGroup = val),
              buildTextField("Phone", (val) => phone = val, keyboard: TextInputType.phone),
              buildTextField("Email", (val) => email = val, keyboard: TextInputType.emailAddress),
              buildTextField("Tags (comma separated)", (val) => tags = val),
              const SizedBox(height: 10),
              // Show tags as chips
              if (tags != null && tags!.isNotEmpty)
                Wrap(
                  spacing: 4,
                  children: tags!
                      .split(',')
                      .map((tag) => Chip(label: Text(tag.trim())))
                      .toList(),
                ),
              const SizedBox(height: 10),
              Row(
                children: [
                  ElevatedButton(onPressed: pickImage, child: const Text("Pick Image")),
                  const SizedBox(width: 10),
                  imageFile != null
                      ? Image.file(imageFile!, width: 80, height: 80, fit: BoxFit.cover)
                      : const Text("No image selected"),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitForm,
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable text field builder
  Widget buildTextField(String label, Function(String) onSaved,
      {TextInputType keyboard = TextInputType.text, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        keyboardType: keyboard,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (val) => val == null || val.isEmpty ? "Required" : null,
        onSaved: (val) => onSaved(val!.trim()),
      ),
    );
  }
}