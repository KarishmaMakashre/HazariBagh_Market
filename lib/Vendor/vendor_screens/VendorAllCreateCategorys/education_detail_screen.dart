import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../VendorProvider/education_provider.dart';
import '../models/education_model.dart';

class EducationDetailScreen extends StatelessWidget {
  final EducationModel education;

  const EducationDetailScreen({super.key, required this.education});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Education Details")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Show first image from API if available
            if (education.images.isNotEmpty)
              Image.network(
                "https://api.hazaribagmarket.in/${education.images[0].replaceAll("\\", "/")}",
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 10),
            buildDetailRow("Course Name", education.name),
            buildDetailRow("Type", education.type),
            buildDetailRow("Description", education.description),
            buildDetailRow("Mode", education.mode),
            buildDetailRow("Address", education.address),
            buildDetailRow("City", education.city),
            buildDetailRow("State", education.state),
            buildDetailRow("Pincode", education.pincode),
            buildDetailRow("Price", education.price.toString()),
            buildDetailRow("Duration", education.duration),
            buildDetailRow("Schedule", education.schedule),
            buildDetailRow("Age Group", education.ageGroup),
            buildDetailRow("Phone", education.phone),
            buildDetailRow("Email", education.email),
            buildDetailRow("Tags", education.tags.join(", ")),
          ],
        ),
      ),
    );
  }

  Widget buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$title: ", style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class EducationListScreen extends StatelessWidget {
  const EducationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Education Courses")),
      body: FutureBuilder(
        future: Provider.of<EducationProvider>(context, listen: false).fetchEducations(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Consumer<EducationProvider>(
              builder: (ctx, provider, _) => ListView.builder(
                itemCount: provider.educations.length,
                itemBuilder: (ctx, i) {
                  final edu = provider.educations[i];
                  return ListTile(
                    title: Text(edu.name),
                    subtitle: Text(edu.type),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => EducationDetailScreen(education: edu),
                      ));
                    },
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}