import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // 🔹 Required for status bar
import '../../widgets/top_header.dart';
import 'order_card.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final w = mq.size.width;
    final h = mq.size.height;
    final statusBarHeight = mq.padding.top;

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xffF6F6F6FF),
      body: Stack(
        children: [
          /// 🔹 CONTENT (space below TopHeader)
          Padding(
            padding: EdgeInsets.only(
              top: statusBarHeight + 70, // 🔥 PERFECT GAP
            ),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: w * 0.04,
                vertical: h * 0.015,
              ),
              children: const [
                OrderCard(
                  orderId: "#K86ZHT1KZ",
                  date: "8 December 2025 | 05:45 PM",
                  productKey: "basmatiRice",
                  qty: 1,
                  price: "₹490",
                  statusKey: "pending",
                  statusColor: Colors.orange,
                  image: "assets/images/electronics.jpg",
                ),
                OrderCard(
                  orderId: "#K86ZHT1KZ",
                  date: "8 December 2025 | 05:45 PM",
                  productKey: "soyabinOil",
                  qty: 1,
                  price: "₹240",
                  statusKey: "completed",
                  statusColor: Colors.green,
                  image: "assets/images/clothe.jpg",
                ),
                OrderCard(
                  orderId: "#K86ZHT1KZ",
                  date: "8 December 2025 | 05:45 PM",
                  productKey: "biscuit",
                  qty: 1,
                  price: "₹40",
                  statusKey: "cancelled",
                  statusColor: Colors.red,
                  image: "assets/images/electronics.jpg",
                ),
              ],
            ),
          ),

          /// 🔝 FIXED TOP HEADER
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: TopHeader(),
          ),
        ],
      ),
    );
  }
}

