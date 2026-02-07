import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../VendorProvider/job_provider.dart';
import '../models/job_model.dart';
import 'vendor_job_create_screen.dart'; // Make sure this exists



class JobListScreen extends StatefulWidget {
  const JobListScreen({super.key, required String storeId});

  @override
  State<JobListScreen> createState() => _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<JobProvider>(context, listen: false).getAllJobs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Jobs",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const VendorJobCreateScreen(subCategoryId: ''),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<JobProvider>(
        builder: (context, jobProvider, child) {
          if (jobProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (jobProvider.jobs.isEmpty) {
            return const Center(child: Text("No jobs found"));
          }

          // GridView with 2 cards per row
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              itemCount: jobProvider.jobs.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 cards per row
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.75, // height/width ratio
              ),
              itemBuilder: (context, index) {
                final job = jobProvider.jobs[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VendorJobDetailsScreen(job: job),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Job image
                        if (job.imagePath != null)
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                            child: Image.network(
                              job.imagePath!,
                              height: 100,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(job.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(job.subCategoryName),
                              const SizedBox(height: 4),
                              Text("Openings: ${job.openings}"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class VendorJobDetailsScreen extends StatelessWidget {
  final JobModel job;
  const VendorJobDetailsScreen({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Job Details",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor, // ✅ primary color
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Open the create job screen when + icon is clicked
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const VendorJobCreateScreen(subCategoryId: ''),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (job.imagePath != null)
              Image.network(
                job.imagePath!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 20),

            detailRow("Job Title", job.title),
            detailRow("Description", job.description),
            detailRow("Job Type", job.jobType),
            detailRow("Sub Category", job.subCategoryName),
            const Divider(),
            detailRow("City", job.location.city),
            detailRow("State", job.location.state),
            detailRow("Country", job.location.country),
            const Divider(),
            detailRow("Salary Min", job.salary.min),
            detailRow("Salary Max", job.salary.max),
            detailRow("Currency", job.salary.currency),
            const Divider(),
            detailRow("Experience Min", job.experience.min),
            detailRow("Experience Max", job.experience.max),
            detailRow("Required Skills", job.requiredSkills),
            detailRow("Openings", job.openings),
            detailRow("Remote Job", job.isRemote ? "Yes" : "No"),
            detailRow("Status", job.status),
          ],
        ),
      ),
    );
  }

  Widget detailRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$label: ", style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value.toString())),
        ],
      ),
    );
  }
}