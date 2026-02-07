import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../VendorProvider/grocery_store_provider.dart';
import 'models/Grocery_store_Model.dart';

class VendorStoreListScreen extends StatefulWidget {
  const VendorStoreListScreen({super.key});

  @override
  State<VendorStoreListScreen> createState() =>
      _VendorStoreListScreenState();
}

class _VendorStoreListScreenState extends State<VendorStoreListScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GroceryStoreProvider>();


    return Scaffold(
      appBar: AppBar(title: const Text("Products")),
      body: provider.products.isEmpty
          ? const Center(child: Text("No products found"))
          : ListView.builder(
        itemCount: provider.products.length,
        itemBuilder: (context, index) {
          final GroceryStore product =
          provider.products[index];

          return Card(
            margin:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: product.images.isNotEmpty
                  ? Image.network(
                "https://api.hazaribagmarket.in/${product.images.first}",
                width: 50,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                const Icon(Icons.image),
              )
                  : const Icon(Icons.shopping_bag),

              title: Text(product.name),

              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("₹${product.sellingPrice}"),
                  Text(
                    "Stock: ${product.stock} ${product.unit}",
                    style: const TextStyle(fontSize: 12),
                  ),
                  Text(
                    "${product.category} • ${product.subCategory}",
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
