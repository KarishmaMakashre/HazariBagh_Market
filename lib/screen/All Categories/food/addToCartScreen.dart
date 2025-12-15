import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/cart_provider.dart';
import '../../cart/cart_page.dart';


class AddToCartScreen extends StatelessWidget {
  final String itemName;
  final String itemPrice;
  final String itemImage;

  const AddToCartScreen({
    super.key,
    required this.itemName,
    required this.itemPrice,
    required this.itemImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Text(
          "Add To Cart",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                itemImage,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              itemName,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "₹$itemPrice",
              style: const TextStyle(
                fontSize: 20,
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),

            const Spacer(),

            ElevatedButton(
              onPressed: () {
                Provider.of<CartProvider>(context, listen: false).addItem({
                  "name": itemName,
                  "price": double.parse(itemPrice),
                  "image": itemImage,
                  "qty": 1,
                  "store": "Fashion Hub",
                });

                /// Navigate to Cart Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CartScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.red,
              ),
              child: const Text(
                "Add Cart",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
