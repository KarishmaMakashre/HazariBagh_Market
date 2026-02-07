import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../VendorProvider/travel_provider.dart';


class VendorTravelScreen extends StatelessWidget {
  final String storeId;
  const VendorTravelScreen({super.key, required this.storeId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VendorTravelProvider()..init(storeId),
      child: Scaffold(
        appBar: AppBar(title: const Text("Tour & Travels")),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Consumer<VendorTravelProvider>(
            builder: (context, provider, _) {
              return Form(
                key: provider.formKey,
                child: ListView(
                  children: [
                    _field("Title",
                            (v) => provider.travel.title = v!),

                    _field("Tour Type",
                            (v) => provider.travel.tourType = v!),

                    _field(
                      "Price Amount",
                          (v) => provider.travel.priceAmount =
                          double.parse(v!),
                      type: TextInputType.number,
                    ),

                    _field(
                      "Days",
                          (v) => provider.travel.days = int.parse(v!),
                      type: TextInputType.number,
                    ),

                    _field(
                      "Nights",
                          (v) => provider.travel.nights = int.parse(v!),
                      type: TextInputType.number,
                    ),

                    _field(
                      "Description",
                          (v) => provider.travel.description = v!,
                      max: 3,
                    ),

                    _field("Address",
                            (v) => provider.travel.address = v!),

                    _field("City",
                            (v) => provider.travel.city = v!),

                    _field("State",
                            (v) => provider.travel.state = v!),

                    _field("Country",
                            (v) => provider.travel.country = v!),

                    _field(
                      "Latitude",
                          (v) => provider.travel.latitude =
                          double.parse(v!),
                      type: TextInputType.number,
                    ),

                    _field(
                      "Longitude",
                          (v) => provider.travel.longitude =
                          double.parse(v!),
                      type: TextInputType.number,
                    ),

                    _field("Start Date",
                            (v) => provider.travel.startDate = v!),

                    _field("End Date",
                            (v) => provider.travel.endDate = v!),

                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => provider.submit(context),
                      child: const Text("Submit Tour"),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _field(
      String label,
      Function(String?) onSave, {
        int max = 1,
        TextInputType type = TextInputType.text,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        maxLines: max,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (v) => v == null || v.isEmpty ? "Required" : null,
        onSaved: onSave,
      ),
    );
  }
}
