import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/widgets/top_header.dart';

import 'order_card.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),

      body: Column(
        children: [

          const TopHeader(),

          SizedBox(height: h * 0.020),

          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: w * 0.03),
              children: [

                OrderCard(
                  orderId: "#K86ZHT1KZ",
                  date: "Placed on 8 December 2025 At 05:45 pm",
                  productName: "Basmati Rice 5kg",
                  qty: "Qty: 1",
                  price: "₹490",
                  status: "Pending",
                  statusColor: Colors.orange,
                  image: 'assets/images/electronics.jpg',
                ),

                OrderCard(
                  orderId: "#K86ZHT1KZ",
                  date: "Placed on 8 December 2025 At 05:45 pm",
                  productName: "Soyabin Oil",
                  qty: "Qty: 1",
                  price: "₹240",
                  status: "Completed",
                  statusColor: Colors.green,
                  image: 'assets/images/clothe.jpg',
                ),

                OrderCard(
                  orderId: "#K86ZHT1KZ",
                  date: "Placed on 8 December 2025 At 05:45 pm",
                  productName: "Biscuit",
                  qty: "Qty: 1",
                  price: "₹40",
                  status: "Cancelled",
                  statusColor: Colors.red,
                  image: 'assets/images/electronics.jpg',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
