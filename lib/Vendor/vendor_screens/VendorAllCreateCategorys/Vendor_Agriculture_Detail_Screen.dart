import 'dart:io';

import 'package:flutter/material.dart';
import '../models/agriculture_model.dart';

class VendorAgricultureDetailScreen extends StatelessWidget {
  final Agriculture agriculture;
  const VendorAgricultureDetailScreen({super.key, required this.agriculture});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Agriculture Details")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${agriculture.name}", style: const TextStyle(fontSize: 16)),
            Text("Description: ${agriculture.description}", style: const TextStyle(fontSize: 16)),
            Text("Listing Type: ${agriculture.listingType}", style: const TextStyle(fontSize: 16)),
            Text("Price: ${agriculture.price}", style: const TextStyle(fontSize: 16)),
            Text("Quantity Available: ${agriculture.quantityAvailable}", style: const TextStyle(fontSize: 16)),
            Text("Service Type: ${agriculture.serviceType}", style: const TextStyle(fontSize: 16)),
            Text("Charge: ${agriculture.charge}", style: const TextStyle(fontSize: 16)),
            Text("Charge Type: ${agriculture.chargeType}", style: const TextStyle(fontSize: 16)),
            Text("Availability: ${agriculture.availability}", style: const TextStyle(fontSize: 16)),
            Text("Service Mode: ${agriculture.serviceMode}", style: const TextStyle(fontSize: 16)),
            Text("District: ${agriculture.district}", style: const TextStyle(fontSize: 16)),
            Text("State: ${agriculture.state}", style: const TextStyle(fontSize: 16)),
            Text("Pincode: ${agriculture.pincode}", style: const TextStyle(fontSize: 16)),
            Text("Country: ${agriculture.country}", style: const TextStyle(fontSize: 16)),
            Text("Latitude: ${agriculture.lat}", style: const TextStyle(fontSize: 16)),
            Text("Longitude: ${agriculture.lng}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text("Required Documents: ${agriculture.requiredDocuments.join(", ")}"),
            const SizedBox(height: 10),
            agriculture.images.isNotEmpty
                ? Wrap(
              spacing: 10,
              children: agriculture.images
                  .map((e) => Image.file(File(e), width: 80, height: 80))
                  .toList(),
            )
                : const Text("No images"),
          ],
        ),
      ),
    );
  }
}
