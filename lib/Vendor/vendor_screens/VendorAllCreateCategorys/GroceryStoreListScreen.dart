import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../VendorProvider/grocery_store_provider.dart';

/// =======================================================
/// 🟢 GROCERY LIST SCREEN
/// =======================================================
class GroceryStoreListScreen extends StatefulWidget {
  const GroceryStoreListScreen({super.key});

  @override
  State<GroceryStoreListScreen> createState() =>
      _GroceryStoreListScreenState();
}

class _GroceryStoreListScreenState
    extends State<GroceryStoreListScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<GroceryStoreProvider>().fetchGroceryProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GroceryStoreProvider>();
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Grocery Products"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle),
            color: primary,
            onPressed: () async {
              // 🔥 WAIT FOR ADD SCREEN TO CLOSE
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AddGroceryProductScreen(),
                ),
              );

              // 🔥 REFRESH LIST AFTER RETURN
              if (mounted) {
                context
                    .read<GroceryStoreProvider>()
                    .fetchGroceryProducts();
              }
            },
          ),
        ],
      ),

      body: provider.isLoading
          ? Center(
        child: CircularProgressIndicator(color: primary),
      )
          : provider.products.isEmpty
          ? const Center(child: Text("No products found"))
          : ListView.builder(
        padding: const EdgeInsets.only(bottom: 8),
        itemCount: provider.products.length,
        itemBuilder: (context, index) {
          final product = provider.products[index];

          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),

              /// IMAGE
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: product.images.isNotEmpty
                    ? Image.network(
                  "https://api.hazaribagmarket.in/${product.images.first}",
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                )
                    : Icon(
                  Icons.shopping_bag,
                  color: primary,
                  size: 30,
                ),
              ),

              /// NAME
              title: Text(
                product.name,
                style:
                theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),

              /// DETAILS
              subtitle: Padding(
                padding:
                const EdgeInsets.only(top: 4),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      "₹${product.sellingPrice}",
                      style: theme
                          .textTheme.bodyMedium
                          ?.copyWith(
                        color: primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Stock: ${product.stock} ${product.unit}",
                      style:
                      theme.textTheme.bodySmall,
                    ),
                    Text(
                      "${product.category} • ${product.subCategory}",
                      style: theme
                          .textTheme.bodySmall
                          ?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "Vendor: ${product.vendorName}",
                      style: theme
                          .textTheme.bodySmall
                          ?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// =======================================================
/// 🟢 ADD GROCERY PRODUCT SCREEN
/// =======================================================
class AddGroceryProductScreen extends StatefulWidget {
  const AddGroceryProductScreen({super.key});

  @override
  State<AddGroceryProductScreen> createState() =>
      _AddGroceryProductScreenState();
}

class _AddGroceryProductScreenState
    extends State<AddGroceryProductScreen> {

  final _name = TextEditingController();
  final _desc = TextEditingController();
  final _mrp = TextEditingController();
  final _price = TextEditingController();
  final _stock = TextEditingController();
  final _unit = TextEditingController();

  File? _image;
  final picker = ImagePicker();

  Future<void> pickImage() async {
    final picked =
    await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _image = File(picked.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<GroceryStoreProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Add Grocery Product")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(children: [

          /// IMAGE PICKER
          GestureDetector(
            onTap: pickImage,
            child: Container(
              height: 140,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),
              child: _image == null
                  ? const Center(
                child: Text("Tap to select image"),
              )
                  : Image.file(_image!, fit: BoxFit.cover),
            ),
          ),

          const SizedBox(height: 12),

          _field("Product Name", _name),
          _field("Description", _desc),
          _field("MRP", _mrp, isNumber: true),
          _field("Selling Price", _price, isNumber: true),
          _field("Stock", _stock, isNumber: true),
          _field("Unit (kg / dozen)", _unit),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                final success =
                await provider.createProduct(
                  name: _name.text,
                  description: _desc.text,
                  mrp: _mrp.text,
                  sellingPrice: _price.text,
                  quantity: "1",
                  stock: _stock.text,
                  unit: _unit.text,
                  categoryId: "69706f694960dffc2880755f",
                  subCategoryId: "6980867733f025d91e016a51",
                  storeId: "697da38e33f025d91e0168ce",
                  image: _image!,
                );

                if (success && mounted) {
                  print("🎉 Product created successfully");
                  Navigator.pop(context); // 👈 GO BACK
                }
              },
              child: const Text("Add Product"),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _field(String label, TextEditingController c,
      {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: c,
        keyboardType:
        isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
