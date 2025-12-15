import 'package:flutter/material.dart';
import '../../widgets/top_header.dart';
import 'order_details_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TopHeader(),
          SizedBox(height: h * 0.015),

          // ---------------- BACK + TITLE ----------------
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.04),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back, size: w * 0.065),
                ),
                SizedBox(width: w * 0.03),
                Text(
                  "Order Management",
                  style: TextStyle(
                    fontSize: w * 0.055,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: h * 0.008),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.04),
            child: Text(
              "Manage Your Orders.",
              style: TextStyle(
                fontSize: w * 0.038,
                color: Colors.black54,
              ),
            ),
          ),

          SizedBox(height: h * 0.02),

          // ---------------- STATUS CARDS ----------------
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                statusCard("0", "Pending", Colors.orange, w, h),
                statusCard("2", "Active", Colors.blue, w, h),
                statusCard("0", "Complete", Colors.green, w, h),
              ],
            ),
          ),

          SizedBox(height: h * 0.02),

          // ---------------- ORDER LIST ----------------
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              children: [
                orderItem(
                  context: context,
                  w: w,
                  h: h,
                  orderId: "ORD001",
                  customer: "Rahul Kumar",
                  items: 2,
                  price: "₹1499",
                  date: "10-03-25",
                  status: "Pending",
                  color: Colors.orange,
                ),
                orderItem(
                  context: context,
                  w: w,
                  h: h,
                  orderId: "ORD002",
                  customer: "Priya Singh",
                  items: 2,
                  price: "₹658",
                  date: "10-03-25",
                  status: "Packed",
                  color: Colors.blue,
                ),
                orderItem(
                  context: context,
                  w: w,
                  h: h,
                  orderId: "ORD003",
                  customer: "Amit Sharma",
                  items: 2,
                  price: "₹370",
                  date: "10-03-25",
                  status: "Shipped",
                  color: Colors.purple,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- STATUS CARD ----------------
  Widget statusCard(String count, String title, Color color, double w, double h) {
    return Container(
      height: h * 0.12,
      width: w * 0.28,
      padding: EdgeInsets.symmetric(vertical: h * 0.015),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(w * 0.03),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: w * 0.04,
            backgroundColor: color.withOpacity(0.15),
            child: Text(
              count,
              style: TextStyle(
                fontSize: w * 0.035,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: h * 0.008),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: color,
              fontSize: w * 0.035,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- ORDER LIST ITEM ----------------
  Widget orderItem({
    required BuildContext context,
    required double w,
    required double h,
    required String orderId,
    required String customer,
    required int items,
    required String price,
    required String date,
    required String status,
    required Color color,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: h * 0.018),
      padding: EdgeInsets.all(w * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(w * 0.03),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ORDER ID + PRICE + STATUS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order Id: $orderId",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: w * 0.04,
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade600,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: h * 0.005),
                    padding: EdgeInsets.symmetric(
                        horizontal: w * 0.025, vertical: h * 0.004),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(w * 0.02),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        fontSize: w * 0.032,
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: h * 0.008),

          Text(
            "Customer: $customer",
            style: TextStyle(fontSize: w * 0.038),
          ),
          Text(
            "Items: $items    ($date)",
            style: TextStyle(fontSize: w * 0.035, color: Colors.black54),
          ),

          SizedBox(height: h * 0.015),

          /// VIEW DETAILS BUTTON
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OrderDetailsScreen()),
              );
            },
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: w * 0.03, vertical: h * 0.008),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(w * 0.02),
                ),
                child: Text(
                  "View Details",
                  style: TextStyle(
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.w600,
                    fontSize: w * 0.032,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
