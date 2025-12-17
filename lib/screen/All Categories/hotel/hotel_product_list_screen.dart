import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Model/product_model.dart';
import '../../../colors/AppColors.dart';
import '../../../provider/hotel_provider.dart'; // 🔑 Use HotelProvider
import '../../../provider/cart_provider.dart';
import '../../../widgets/top_header.dart';

class HotelProductListScreen extends StatelessWidget {
  final String categoryTitle;

  const HotelProductListScreen({
    super.key,
    required this.categoryTitle,
  });

  @override
  Widget build(BuildContext context) {
    // 🔑 Use HotelProvider
    final hotelProvider = context.watch<HotelProvider>();
    final List<ProductModel> products =
    hotelProvider.getProductsByCategory(categoryTitle);

    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: Column(
        children: [
          /// 🔝 TOP HEADER
          const TopHeader(),

          /// 🔙 BACK BUTTON + TITLE
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: 8),
            child: Row(
              children: [
                // Back Button
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: AppColors.success),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                SizedBox(width: w * 0.02),
                // Title
                Text(
                  categoryTitle,
                  style: const TextStyle(
                    color: AppColors.success,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          /// 🧺 PRODUCT LIST (Expanded to fill remaining space)
          Expanded(
            child: products.isEmpty
                ? Center(
              child: Text(
                "No listings currently available for $categoryTitle.",
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
                : ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                // Reusing the same card structure for visual consistency
                return _buildProductCard(context, product, w);
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 🟢 Product Card Widget to display individual item details
  Widget _buildProductCard(BuildContext context, ProductModel product, double w) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    // Define responsive sizes
    final imageSize = w * 0.20;
    final horizontalPadding = w * 0.03;

    return Card(
      margin: EdgeInsets.symmetric(vertical: w * 0.02),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(horizontalPadding),
        child: Row(
          children: [
            // 🖼 Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                product.image,
                width: imageSize,
                height: imageSize,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: horizontalPadding),

            // 📝 Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: w * 0.01),
                  Text(
                    product.price,
                    style: TextStyle(
                      fontSize: w * 0.035,
                      color: AppColors.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // 🛒 Action Button (Add to Cart/Book)
            ElevatedButton.icon(
              onPressed: () {
                // Assuming hotel/restaurant items also go to a cart for booking/ordering
                cartProvider.addItem({
                  "name": product.name,
                  "price": double.tryParse(product.price.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0.0,
                  "qty": 1,
                  "image": product.image,
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("${product.name} added to cart! (${cartProvider.cartCount} items)"),
                    duration: const Duration(milliseconds: 800),
                  ),
                );
              },
              icon: Icon(Icons.shopping_bag, size: w * 0.045), // Using a different icon for context
              label: Text("Add Cart"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                padding: EdgeInsets.symmetric(horizontal: w * 0.02, vertical: w * 0.015),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: TextStyle(fontSize: w * 0.035),
              ),
            ),
          ],
        ),
      ),
    );
  }
}