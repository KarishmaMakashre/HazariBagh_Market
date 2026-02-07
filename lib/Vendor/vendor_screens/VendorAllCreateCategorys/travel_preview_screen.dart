import 'package:flutter/material.dart';

import '../models/travel_model.dart';

class VendorTravelPreviewScreen extends StatelessWidget {
  final TravelModel travel;

  const VendorTravelPreviewScreen({super.key, required this.travel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tour Preview")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _item("Title", travel.title),
            _item("Tour Type", travel.tourType),
            _item("Price Amount", travel.priceAmount.toString()),
            _item("Days", travel.days.toString()),
            _item("Nights", travel.nights.toString()),
            _item("Description", travel.description),
            _item("Address", travel.address),
            _item("City", travel.city),
            _item("State", travel.state),
            _item("Country", travel.country),
            _item("Latitude", travel.latitude.toString()),
            _item("Longitude", travel.longitude.toString()),
            _item("Start Date", travel.startDate),
            _item("End Date", travel.endDate),
          ],
        ),
      ),
    );
  }

  Widget _item(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 16)),
        const Divider(),
      ],
    );
  }
}
