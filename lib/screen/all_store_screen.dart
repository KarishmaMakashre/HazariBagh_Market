import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/screen/store_details_screen.dart';
import '../../widgets/top_header.dart';
import '../Model/store_model.dart';

class AllStoreScreen extends StatelessWidget {
  const AllStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Correctly define and use the size variable
    final size = MediaQuery.of(context).size;
    // You can also define width and height for cleaner access
    final double screenWidth = size.width;
    final double screenHeight = size.height; // Not strictly needed here but good practice

    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TopHeader(),
          const SizedBox(height: 10),

          // **CORRECTION HERE:** Replaced undefined 'width' with 'screenWidth' or 'size.width'
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.03), // Use screenWidth
            child: Row(
              children: [
                Icon(Icons.arrow_back, color: Colors.blue, size: screenWidth * 0.055), // Use screenWidth
                SizedBox(width: screenWidth * 0.02), // Use screenWidth
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Back",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: screenWidth * 0.038, // Use screenWidth
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          /// CONTENT
          Expanded(
            child: Padding(
              // Consider using screenWidth for horizontal padding too if you want it relative to screen size
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04), // Example: 4% of width
              // Original: const EdgeInsets.symmetric(horizontal: 16),

              child: ListView.builder(
                itemCount: nearbyStores.length,
                itemBuilder: (context, index) {
                  final store = nearbyStores[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => StoreDetailsScreen(store: store),
                        ),
                      );
                    },

                    child: Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.07),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),

                      child: Row(
                        children: [
                          /// IMAGE
                          ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image.asset(
                              store.image,
                              // Correctly using size.width for relative sizing
                              height: screenWidth * 0.22,
                              width: screenWidth * 0.22,
                              fit: BoxFit.cover,
                            ),
                          ),

                          const SizedBox(width: 12),

                          /// DETAILS
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // You might also consider using screenWidth for font sizes for better responsiveness
                                Text(
                                  store.name,
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.042, // Example: 4.2% of width
                                    fontWeight: FontWeight.w700,
                                  ),
                                  // Original: fontSize: 16,
                                ),

                                const SizedBox(height: 6),

                                Text(
                                  store.category,
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.038, // Example: 3.8% of width
                                    color: Colors.grey.shade600,
                                  ),
                                  // Original: fontSize: 14,
                                ),

                                const SizedBox(height: 6),

                                Row(
                                  children: [
                                    Icon(Icons.location_on,
                                        size: screenWidth * 0.04, color: Colors.red), // Use screenWidth
                                    const SizedBox(width: 4),
                                    Text(
                                      store.distance,
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.035, // Example: 3.5% of width
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 6),

                                Row(
                                  children: [
                                    Icon(Icons.star,
                                        size: screenWidth * 0.04, color: Colors.orange), // Use screenWidth
                                    const SizedBox(width: 4),
                                    Text(
                                      "${store.rating}",
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.038, // Example: 3.8% of width
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}