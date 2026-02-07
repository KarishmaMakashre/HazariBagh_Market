import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../VendorProvider/Fashion_Provider.dart';

class Vendorfashionproductlistscreen extends StatefulWidget {
  const Vendorfashionproductlistscreen({super.key});

  @override
  State<Vendorfashionproductlistscreen> createState() =>
      _VendorfashionproductlistscreenState();
}

class _VendorfashionproductlistscreenState
    extends State<Vendorfashionproductlistscreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<FashionProductProvider>().getFashionStores();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FashionProductProvider>();
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        title: const Text("Fashion Stores"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.stores.isEmpty
          ? const Center(child: Text("No fashion stores found"))
          : GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: provider.stores.length,
        itemBuilder: (_, index) {
          final store = provider.stores[index];

          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: store.storeImage.isEmpty
                      ? const Icon(Icons.store, size: 80)
                      : Image.network(
                    "https://api.hazaribagmarket.in/${store.storeImage}",
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
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
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Category: ${store.shopCategory}",
                        style: const TextStyle(fontSize: 12),
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