import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/screen/home/home_screen.dart';
import '../../widgets/top_header.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,

      body: Column(
        children: [
          const TopHeader(),

          /// ✅ TITLE BAR
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            child: Row(
              children: [
                // ✅ BACK BUTTON
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
                  },
                  icon: const Icon(Icons.keyboard_backspace_outlined, size: 20),
                ),

                // const SizedBox(width: 2),

                // ✅ SHOPPING CART TEXT
                const Text(
                  "Shopping Cart",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),


          /// ✅ TODAY + MARK AS READ
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Today", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Make as read",
                    style: TextStyle(
                      color: Color(0xFF3670A3),
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          ),

          const SizedBox(height: 10),

          /// ✅ NOTIFICATION LIST
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: [

                _notificationCard(
                  image: "assets/images/clothe.jpg",
                  transactionId: "A23B567K",
                  date: "22/09/32",
                  status: "Out for Delivery",
                  price: "₹12,000",
                ),

                _notificationCard(
                  image: "assets/images/clothe.jpg",
                  transactionId: "A23B567K",
                  date: "22/09/32",
                  status: "Out for Delivery",
                  price: "₹15,000",
                ),

                _notificationCard(
                  image: "assets/images/clothe.jpg",
                  transactionId: "A23B567K",
                  date: "22/09/32",
                  status: "Out for Delivery",
                  price: "₹18,000",
                ),

                _notificationCard(
                  image: "assets/images/clothe.jpg",
                  transactionId: "A23B567K",
                  date: "22/09/32",
                  status: "Out for Delivery",
                  price: "₹9,000",
                ),

                _notificationCard(
                  image: "assets/images/clothe.jpg",
                  transactionId: "A23B567K",
                  date: "22/09/32",
                  status: "Out for Delivery",
                  price: "₹10,000",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ SINGLE NOTIFICATION CARD
  static Widget _notificationCard({
    required String image,
    required String transactionId,
    required String date,
    required String status,
    required String price,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          /// ✅ PRODUCT IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              image,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 10),

          /// ✅ ORDER DETAILS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Transaction ID : $transactionId",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text("Scheduled for : $date",
                    style: const TextStyle(fontSize: 12)),
                Text(status,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange)),
                Text(price,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green)),
              ],
            ),
          ),

          /// ✅ TRACK ORDER BUTTON
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3670A3),
              minimumSize: const Size(70, 30),
              padding: EdgeInsets.zero,
            ),
            onPressed: () {},
            child: const Text(
              "Track Order",
              style: TextStyle(fontSize: 10, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
