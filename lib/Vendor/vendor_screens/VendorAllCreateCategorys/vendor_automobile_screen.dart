import 'package:flutter/material.dart';

class VendorAutomobileScreen extends StatelessWidget {
  final String storeId;
  const VendorAutomobileScreen({super.key, required this.storeId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Automobiles")),
      body: Center(child: Text("Automobile Screen for store: $storeId")),
    );
  }
}