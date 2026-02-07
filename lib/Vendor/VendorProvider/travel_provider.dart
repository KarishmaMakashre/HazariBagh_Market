import 'package:flutter/material.dart';

import '../vendor_screens/VendorAllCreateCategorys/travel_preview_screen.dart';
import '../vendor_screens/models/travel_model.dart';


class VendorTravelProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  late TravelModel travel;

  void init(String vendorId) {
    travel = TravelModel(
      vendor: vendorId,
      title: "",
      tourType: "",
      priceType: "per_person",
      priceAmount: 0,
      priceCurrency: "INR",
      days: 0,
      nights: 0,
      description: "",
      address: "",
      city: "",
      state: "",
      country: "India",
      latitude: 0,
      longitude: 0,
      startDate: "",
      endDate: "",
    );
  }

  void submit(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VendorTravelPreviewScreen(travel: travel),
        ),
      );
    }
  }
}
