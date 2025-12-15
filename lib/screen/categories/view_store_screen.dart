import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/store_provider.dart';
import '../../provider/cart_provider.dart';
import '../../widgets/top_header.dart';

class ViewStoreScreen extends StatelessWidget {
  const ViewStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final storeProvider = Provider.of<StoreProvider>(context);
    final store = storeProvider.selectedStore;

    if (store == null) {
      return const Scaffold(
        body: Center(child: Text("No Store Selected")),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          const TopHeader(),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  /// BACK BUTTON
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Row(
                        children: const [
                          Icon(Icons.arrow_back),
                          SizedBox(width: 6),
                          Text(
                            "Back to Store",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// STORE BOX
                  storeTopCard(store),

                  const SizedBox(height: 10),

                  /// PRODUCT TITLE
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text("Available Products",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),

                  const SizedBox(height: 8),

                  /// ***********************
                  ///   UPDATED GRID VIEW
                  /// ***********************
                  GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Image.asset(
                                "assets/images/clothe.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),

                            const Padding(
                              padding: EdgeInsets.all(6),
                              child: Text("Product Name",
                                  style: TextStyle(fontSize: 12)),
                            ),

                            /// UPDATED Add Cart Button
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF3670A3),
                                minimumSize: const Size(70, 26),
                              ),
                              onPressed: () {
                                Provider.of<CartProvider>(context, listen: false).addItem({
                                  "name": "Product Name",
                                  "price": 100.0,
                                  "qty": 1,
                                  "image": "assets/images/clothe.jpg",
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Added to Cart")),
                                );
                              },
                              child: const Text(
                                "Add Cart",
                                style: TextStyle(color: Colors.white, fontSize: 11),
                              ),
                            ),

                          ],
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  /// REVIEWS
                  customerReviews(),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /// STORE CARD (Unchanged)
  Widget storeTopCard(store) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  store.image,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 12,
                left: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(store.name,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text("${store.rating} ★",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 11)),
                        ),
                        const SizedBox(width: 8),
                        const Text("0.8 km away",
                            style:
                            TextStyle(color: Colors.white, fontSize: 11)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 18),
                    const SizedBox(width: 6),
                    Expanded(child: Text(store.address)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.phone, size: 18),
                    const SizedBox(width: 6),
                    Text(store.phone),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 18),
                    const SizedBox(width: 6),
                    Text(store.time),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// CUSTOMER REVIEWS
  Widget customerReviews() {
    return Column(
      children: [
        reviewCard(
          name: "Rahul Kumar",
          time: "2 days ago",
          review: "Excellent store with great products and service!",
          rating: 5,
        ),
        reviewCard(
          name: "Priya Singh",
          time: "1 week ago",
          review: "Good quality products at reasonable prices.",
          rating: 4,
        ),
        reviewCard(
          name: "Amit Sharma",
          time: "2 weeks ago",
          review: "Very fresh products and quick delivery.",
          rating: 5,
        ),
      ],
    );
  }

  /// REVIEW CARD
  Widget reviewCard({
    required String name,
    required String time,
    required String review,
    required int rating,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue,
                child:
                Text(name[0], style: const TextStyle(color: Colors.white)),
              ),
              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                    Text(time,
                        style:
                        const TextStyle(fontSize: 11, color: Colors.grey)),
                  ],
                ),
              ),

              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    size: 16,
                    color: Colors.orange,
                  );
                }),
              ),
            ],
          ),

          const SizedBox(height: 10),
          Text(review,
              style:
              const TextStyle(fontSize: 13, color: Colors.black87)),
        ],
      ),
    );
  }
}
