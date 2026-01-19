import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/profile_provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController();
  final dobController = TextEditingController();
  String gender = "male";

  @override
  void initState() {
    super.initState();
    final user = context.read<ProfileProvider>().user;

    if (user != null) {
      nameController.text = user.name ?? "";
      gender = user.gender ?? "male";
      dobController.text = user.dob?.split("T").first ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProfileProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _field("Name", nameController),
            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: gender,
              items: const [
                DropdownMenuItem(value: "male", child: Text("Male")),
                DropdownMenuItem(value: "female", child: Text("Female")),
              ],
              onChanged: (v) => setState(() => gender = v!),
              decoration: _decoration("Gender"),
            ),

            const SizedBox(height: 16),
            _field("DOB (YYYY-MM-DD)", dobController),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: provider.loading
                    ? null
                    : () async {
                  final success =
                  await provider.updateProfile(
                    name: nameController.text.trim(),
                    gender: gender,
                    dob: dobController.text.trim(),
                  );

                  if (success && context.mounted) {
                    Navigator.pop(context, true); // 🔥 RETURN TRUE
                  }
                },
                child: provider.loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Save Changes"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController c) {
    return TextField(
      controller: c,
      decoration: _decoration(label),
    );
  }

  InputDecoration _decoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
