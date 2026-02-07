import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/Vendor/vendor_screens/VendorAllCreateCategorys/property_create_screen.dart';
import 'package:provider/provider.dart';

import '../../VendorProvider/vendor_Property_Provider.dart';

class VendorPropertyScreen extends StatefulWidget {
  const VendorPropertyScreen({super.key});

  @override
  State<VendorPropertyScreen> createState() => _VendorPropertyScreenState();
}

class _VendorPropertyScreenState extends State<VendorPropertyScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch properties when screen opens
    Future.microtask(() =>
        Provider.of<VendorPropertyProvider>(context, listen: false)
            .fetchAllProperties());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Properties'),
        backgroundColor: Theme.of(context).primaryColor, // primary color background
        foregroundColor: Colors.white, // title & icons white
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navigate to PropertyCreateScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PropertyCreateScreen(storeId: 'storeId'),
                ),
              );
            },
          ),
        ],
      ),      body: Consumer<VendorPropertyProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.properties.isEmpty) {
            return const Center(child: Text('No properties found'));
          }

          // Use GridView for 2 cards per row
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 cards per row
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.7, // adjust height of cards
            ),
            itemCount: provider.properties.length,
            itemBuilder: (context, index) {
              final property = provider.properties[index];

              return Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // If there are images, show first one
                      property.images.isNotEmpty
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          property.images[0],
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                          : Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.home, size: 50),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        property.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${property.city}, ${property.state}',
                        style: const TextStyle(color: Colors.grey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Price: ${property.priceAmount} ${property.priceType}',
                        style: const TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text('${property.bedrooms} BHK | ${property.bathrooms} Bath'),
                    ],
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