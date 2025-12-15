import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Model/product_model.dart';
import '../../../colors/AppColors.dart';
import '../../../provider/grocery_provider.dart';
import '../../../provider/cart_provider.dart';
import '../../../widgets/top_header.dart';

class ProductListScreen extends StatelessWidget {
  final String categoryTitle;

  const ProductListScreen({
    super.key,
    required this.categoryTitle,
  });

  @override
  Widget build(BuildContext context) {
    final groceryProvider = context.watch<GroceryProvider>();
    final List<ProductModel> products =
    groceryProvider.getProductsByCategory(categoryTitle);

    final w = MediaQuery.of(context).size.width; // 🔑 Width is defined here

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: Column(
        children: [
          /// 🔝 TOP HEADER
          const TopHeader(),

          /// 🔙 BACK BUTTON + TITLE (Custom Header)
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
                "No products currently listed for $categoryTitle.",
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
                : ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                // 🔑 Pass context AND width (w) to the card builder
                return _buildProductCard(context, product, w);
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 🟢 Product Card Widget to display individual item details
  // 🔑 Updated signature to accept double w
  Widget _buildProductCard(BuildContext context, ProductModel product, double w) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    // Define responsive sizes
    final imageSize = w * 0.20; // Approx 80px for standard 400w device
    final horizontalPadding = w * 0.03; // Approx 12px

    return Card(
      // 🔑 Use w for responsive margin
      margin: EdgeInsets.symmetric(vertical: w * 0.02),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        // 🔑 Use w for responsive padding
        padding: EdgeInsets.all(horizontalPadding),
        child: Row(
          children: [
            // 🖼 Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                product.image,
                width: imageSize, // 🔑 Responsive image size
                height: imageSize, // 🔑 Responsive image size
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: horizontalPadding), // 🔑 Responsive spacing

            // 📝 Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: w * 0.04, // 🔑 Responsive font size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: w * 0.01), // 🔑 Responsive spacing
                  Text(
                    product.price,
                    style: TextStyle(
                      fontSize: w * 0.035, // 🔑 Responsive font size
                      color: AppColors.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // 🛒 Action Button
            ElevatedButton.icon(
              onPressed: () {
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
              icon: Icon(Icons.add_shopping_cart, size: w * 0.045), // 🔑 Responsive icon size
              label: Text("Add cart"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                padding: EdgeInsets.symmetric(horizontal: w * 0.02, vertical: w * 0.015), // 🔑 Responsive padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: TextStyle(fontSize: w * 0.035), // 🔑 Responsive text size
              ),
            ),
          ],
        ),
      ),
    );
  }
}