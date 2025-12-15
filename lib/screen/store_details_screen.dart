import 'package:flutter/material.dart';
import '../Model/store_model.dart';

class StoreDetailsScreen extends StatelessWidget {
  final StoreModel store;

  const StoreDetailsScreen({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(store.name),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                store.image,
                height: size.height * 0.25,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 16),

            /// TITLE
            Text(
              store.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            /// CATEGORY
            Text(
              store.category,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
            ),

            const SizedBox(height: 16),

            /// DISTANCE + RATING
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.red),
                Text(
                  store.distance,
                  style: const TextStyle(fontSize: 16),
                ),

                const SizedBox(width: 20),

                const Icon(Icons.star, color: Colors.orange),
                Text(
                  store.rating.toString(),
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Divider(color: Colors.grey.shade300),

            const SizedBox(height: 20),

            const Text(
              "About Store",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(
              "This is a sample description of the store. "
                  "You can add more detailed information here.",
              style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }
}
