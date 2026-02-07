import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../VendorProvider/job_provider.dart';
import '../models/job_model.dart';
import 'vendor_job_details_screen.dart';

class VendorJobCreateScreen extends StatefulWidget {
  final String subCategoryId;
  const VendorJobCreateScreen({super.key, required this.subCategoryId});

  @override
  State<VendorJobCreateScreen> createState() => _VendorJobCreateScreenState();
}

class _VendorJobCreateScreenState extends State<VendorJobCreateScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController jobTypeController = TextEditingController();
  final TextEditingController requiredSkillsController = TextEditingController();
  final TextEditingController openingsController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController minSalaryController = TextEditingController();
  final TextEditingController maxSalaryController = TextEditingController();
  final TextEditingController currencyController = TextEditingController();
  final TextEditingController minExperienceController = TextEditingController();
  final TextEditingController maxExperienceController = TextEditingController();

  bool isRemote = false;

  String subCategoryName = '';

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    jobTypeController.dispose();
    requiredSkillsController.dispose();
    openingsController.dispose();
    cityController.dispose();
    stateController.dispose();
    countryController.dispose();
    minSalaryController.dispose();
    maxSalaryController.dispose();
    currencyController.dispose();
    minExperienceController.dispose();
    maxExperienceController.dispose();
    super.dispose();
  }

  void saveJob() async {
    if (_formKey.currentState!.validate()) {
      final job = JobModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(), // local ID
        title: titleController.text,
        description: descriptionController.text,
        jobType: jobTypeController.text,
        subCategoryId: widget.subCategoryId,
        subCategoryName: subCategoryName.isEmpty ? '-' : subCategoryName,
        requiredSkills: requiredSkillsController.text,
        openings: int.tryParse(openingsController.text) ?? 0,
        isRemote: isRemote,
        status: 'Active',
        imagePath: null, // Add image later if needed
        vendorId: null,
        location: Location(
          city: cityController.text,
          state: stateController.text,
          country: countryController.text,
        ),
        salary: Salary(
          min: int.tryParse(minSalaryController.text) ?? 0,
          max: int.tryParse(maxSalaryController.text) ?? 0,
          currency: currencyController.text,
        ),
        experience: Experience(
          min: int.tryParse(minExperienceController.text) ?? 0,
          max: int.tryParse(maxExperienceController.text) ?? 0,
        ),
      );

      final success = await Provider.of<JobProvider>(context, listen: false).createJob(job);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Job created successfully!")),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => VendorJobDetailsScreen(job: job),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create Job",
          style: TextStyle(color: Colors.white), // Title text color white
        ),
        backgroundColor: Theme.of(context).primaryColor, // AppBar uses primary color
        iconTheme: const IconThemeData(color: Colors.white), // Back button / icons color white
      ),      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              buildTextField("Job Title", titleController),
              buildTextField("Description", descriptionController, maxLines: 3),
              buildTextField("Job Type", jobTypeController),
              buildTextField("Sub Category Name", TextEditingController(text: subCategoryName),
                  onChanged: (val) => subCategoryName = val),
              const SizedBox(height: 10),
              buildTextField("Required Skills", requiredSkillsController),
              buildTextField("Openings", openingsController, keyboardType: TextInputType.number),
              SwitchListTile(
                title: const Text("Remote Job"),
                value: isRemote,
                onChanged: (val) => setState(() => isRemote = val),
              ),
              const Divider(),
              const Text("Location", style: TextStyle(fontWeight: FontWeight.bold)),
              buildTextField("City", cityController),
              buildTextField("State", stateController),
              buildTextField("Country", countryController),
              const Divider(),
              const Text("Salary", style: TextStyle(fontWeight: FontWeight.bold)),
              buildTextField("Min Salary", minSalaryController, keyboardType: TextInputType.number),
              buildTextField("Max Salary", maxSalaryController, keyboardType: TextInputType.number),
              buildTextField("Currency", currencyController),
              const Divider(),
              const Text("Experience", style: TextStyle(fontWeight: FontWeight.bold)),
              buildTextField("Min Experience", minExperienceController, keyboardType: TextInputType.number),
              buildTextField("Max Experience", maxExperienceController, keyboardType: TextInputType.number),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveJob,
                child: const Text("Create Job"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      {int maxLines = 1, TextInputType keyboardType = TextInputType.text, Function(String)? onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (val) => val == null || val.isEmpty ? "$label is required" : null,
        onChanged: onChanged,
      ),
    );
  }
}