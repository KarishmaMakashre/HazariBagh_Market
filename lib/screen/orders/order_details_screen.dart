import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String orderId;
  final String date;
  final String productName;
  final String qty;
  final String price;
  final String status;
  final Color statusColor;
  final String image;

  const OrderDetailsScreen({
    super.key,
    required this.orderId,
    required this.date,
    required this.productName,
    required this.qty,
    required this.price,
    required this.status,
    required this.statusColor,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
        backgroundColor: Colors.blue,
      ),

      body: Padding(
        padding: EdgeInsets.all(w * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(w * 0.03),
                child: Image.asset(
                  image,
                  height: h * 0.22,
                  width: w * 0.6,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: h * 0.02),

            Text("Order ID: $orderId",
                style: TextStyle(fontSize: w * 0.045, fontWeight: FontWeight.bold)),

            SizedBox(height: h * 0.01),

            Text(date, style: TextStyle(fontSize: w * 0.035, color: Colors.grey)),

            Divider(height: h * 0.04),

            Text("Product: $productName",
                style: TextStyle(fontSize: w * 0.040, fontWeight: FontWeight.w500)),

            Text(qty, style: TextStyle(fontSize: w * 0.035, color: Colors.grey)),

            SizedBox(height: h * 0.015),

            Text("Price: $price",
                style: TextStyle(fontSize: w * 0.040, fontWeight: FontWeight.w600)),

            SizedBox(height: h * 0.015),

            Text(
              "Status: $status",
              style: TextStyle(
                fontSize: w * 0.040,
                fontWeight: FontWeight.bold,
                color: statusColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
