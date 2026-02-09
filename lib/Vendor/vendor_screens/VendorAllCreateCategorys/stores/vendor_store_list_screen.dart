import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/Vendor_store_provider.dart';


class StoreListScreen extends StatefulWidget {
  const StoreListScreen({super.key});

  @override
  State<StoreListScreen> createState() => _StoreListScreenState();
}

class _StoreListScreenState extends State<StoreListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<VendorStoreProvider>().getAllStores());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Stores')),
      body: Consumer<VendorStoreProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (provider.stores.isEmpty) {
            return const Center(
              child: Text('No stores found'),
            );
          }

          return ListView.builder(
            itemCount: provider.stores.length,
            itemBuilder: (context, index) {
              final store = provider.stores[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(store.name),
                  subtitle: Text(
                    'Type: ${store.storeType}\nStatus: ${store.status}',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
