import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../VendorProvider/govt_provider.dart';
import '../models/govt_model.dart';

class GovtServiceScreen extends StatelessWidget {
  const GovtServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GovtProvider()..fetchGovtServices(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Government Services"),
        ),
        body: Consumer<GovtProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.services.isEmpty) {
              return const Center(child: Text("No services found"));
            }

            return ListView.builder(
              itemCount: provider.services.length,
              itemBuilder: (context, index) {
                final GovtModel service = provider.services[index];

                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(service.name),
                    subtitle: Text(
                      service.processingTimeDays ?? "Processing time not available",
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Optional: navigate to details screen
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text(service.name),
                          content: Text(
                            service.requiredDocuments?.join("\n\n") ?? "No documents",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Close"),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}