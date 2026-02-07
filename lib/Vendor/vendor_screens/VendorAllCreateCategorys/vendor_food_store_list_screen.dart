import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/Vendor/vendor_screens/VendorAllCreateCategorys/vendor_food_store_screen.dart';
import 'package:provider/provider.dart';

import '../../VendorProvider/food_store_provider.dart';

class VendorFoodStoreListScreen extends StatefulWidget {
  const VendorFoodStoreListScreen({super.key});

  @override
  State<VendorFoodStoreListScreen> createState() =>
      _VendorFoodStoreListScreenState();
}

class _VendorFoodStoreListScreenState
    extends State<VendorFoodStoreListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<FoodStoreProvider>().getAllFoodStores();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FoodStoreProvider>();
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        title: const Text("My Food Stores"),

        // ➕ ICON IN APPBAR
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const VendorFoodStoreScreen(storeId: ''),
                ),
              );
            },
          ),
        ],
      ),

      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.error != null
          ? Center(child: Text(provider.error!))
          : provider.stores.isEmpty
          ? const Center(child: Text("No Store Found"))
          : GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,       // 🔥 2 cards in a row
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,   // card height control
        ),
        itemCount: provider.stores.length,
        itemBuilder: (_, i) {
          final store = provider.stores[i];

          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // IMAGE
                Expanded(
                  child: store.images.isNotEmpty
                      ? ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Image.network(
                      "https://api.hazaribagmarket.in/${store.images.first}",
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                      : const Center(
                    child: Icon(Icons.store, size: 40),
                  ),
                ),

                // DETAILS
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        store.storeName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        store.address.city,
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(height: 6),

                      Row(
                        children: [
                          Icon(
                            store.isOpen
                                ? Icons.check_circle
                                : Icons.cancel,
                            color: store.isOpen
                                ? Colors.green
                                : Colors.red,
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            store.isOpen ? "Open" : "Closed",
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}