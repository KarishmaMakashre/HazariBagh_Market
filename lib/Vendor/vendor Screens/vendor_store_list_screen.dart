import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../VendorProvider/product_provider.dart';

class VendorStoreListScreen extends StatefulWidget {
  const VendorStoreListScreen({super.key});

  @override
  State<VendorStoreListScreen> createState() =>
      _VendorStoreListScreenState();
}

class _VendorStoreListScreenState extends State<VendorStoreListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ProductProvider>().fetchVendorStores();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Vendor Stores")),
      body: provider.stores.isEmpty
          ? const Center(child: Text("No stores found"))
          : ListView.builder(
        itemCount: provider.stores.length,
        itemBuilder: (context, index) {
          final store = provider.stores[index];

          return Card(
            child: ListTile(
              leading: store.imageUrl != null
                  ? Image.network(
                "https://api.hazaribagmarket.in/${store.imageUrl}",
                width: 50,
                fit: BoxFit.cover,
              )
                  : const Icon(Icons.store),
              title: Text(store.name),
              subtitle: Text(store.description),
            ),
          );
        },
      ),
    );
  }
}
