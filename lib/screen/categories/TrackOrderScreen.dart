import 'package:flutter/material.dart';

import '../../widgets/top_header.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,



      body: SingleChildScrollView(
        child: Column(
          children: [
            const TopHeader(),

            const SizedBox(height: 2),

            // ✅ BACK TITLE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  children: const [
                    Icon(Icons.arrow_back,color: Color(0xFF3670A3),),
                    SizedBox(width: 6),
                    Text(
                      "Live Track Order",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF3670A3)
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ✅ MAP IMAGE PLACEHOLDER
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade300,
                image: const DecorationImage(
                  image: AssetImage("assets/Images/map_demo.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Live Tracking",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // ✅ DELIVERY BOY INFO
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  const SizedBox(width: 10),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Ankit Sharma",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("Delivery Boy",
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ),

                  IconButton(
                    icon: const Icon(Icons.message),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.call),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // ✅ ORDER STATUS TIMELINE
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StatusRow(
                      icon: Icons.check_circle,
                      title: "Order Completed",
                      subtitle: "Confirmed on 22 Aug 2023",
                      active: true),

                  StatusRow(
                      icon: Icons.local_shipping,
                      title: "Being sent by Courier",
                      subtitle: "Estimated time 15-20 mins",
                      active: true),

                  StatusRow(
                      icon: Icons.watch_later,
                      title: "Waiting for pickup",
                      subtitle: "Driver on the way",
                      active: false),

                  StatusRow(
                      icon: Icons.verified,
                      title: "Payment has been verified",
                      subtitle: "Success",
                      active: false),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // ✅ ORDER CANCELLED BUTTON
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () {},
                child: const Text("Order Cancelled"),
              ),
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

// ✅ STATUS ROW WIDGET
class StatusRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool active;

  const StatusRow({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: active ? Colors.green : Colors.grey,
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
