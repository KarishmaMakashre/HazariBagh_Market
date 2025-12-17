import 'package:flutter/material.dart';
import '../../widgets/top_header.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});

  static const Color primaryColor = Color(0xFF3670A3);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TopHeader(),

            SizedBox(height: h * 0.005),

            /// 🔙 BACK + TITLE
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: w * 0.04,
                vertical: h * 0.01,
              ),
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: primaryColor,
                      size: w * 0.055,
                    ),
                    SizedBox(width: w * 0.02),
                    Text(
                      "Live Track Order",
                      style: TextStyle(
                        fontSize: w * 0.045,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: h * 0.02),

            /// 🗺 MAP PREVIEW
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child: Container(
                height: h * 0.25,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(w * 0.04),
                  color: Colors.grey.shade300,
                  image: const DecorationImage(
                    image: AssetImage("assets/Images/map_demo.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.all(w * 0.03),
                    child: Text(
                      "Live Tracking",
                      style: TextStyle(
                        fontSize: w * 0.04,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: h * 0.02),

            /// 🚴 DELIVERY BOY INFO
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child: Container(
                padding: EdgeInsets.all(w * 0.035),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(w * 0.04),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: w * 0.06,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person,
                          color: Colors.white, size: w * 0.06),
                    ),
                    SizedBox(width: w * 0.03),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ankit Sharma",
                            style: TextStyle(
                              fontSize: w * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: h * 0.003),
                          Text(
                            "Delivery Boy",
                            style: TextStyle(
                              fontSize: w * 0.032,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                    IconButton(
                      icon: Icon(Icons.message,
                          size: w * 0.06, color: primaryColor),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.call,
                          size: w * 0.06, color: primaryColor),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: h * 0.025),

            /// 📦 ORDER STATUS
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child: Container(
                padding: EdgeInsets.all(w * 0.035),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(w * 0.04),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StatusRow(
                      icon: Icons.check_circle,
                      title: "Order Completed",
                      subtitle: "Confirmed on 22 Aug 2023",
                      active: true,
                    ),
                    StatusRow(
                      icon: Icons.local_shipping,
                      title: "Being sent by Courier",
                      subtitle: "Estimated time 15-20 mins",
                      active: true,
                    ),
                    StatusRow(
                      icon: Icons.watch_later,
                      title: "Waiting for pickup",
                      subtitle: "Driver on the way",
                      active: false,
                    ),
                    StatusRow(
                      icon: Icons.verified,
                      title: "Payment has been verified",
                      subtitle: "Success",
                      active: false,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: h * 0.025),

            /// ❌ CANCEL BUTTON
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child: SizedBox(
                width: double.infinity,
                height: h * 0.065,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(w * 0.03),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Order Cancelled",
                    style: TextStyle(
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: h * 0.1),
          ],
        ),
      ),
    );
  }
}

/// ✅ STATUS ROW
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
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: h * 0.012),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: active ? Colors.green : Colors.grey,
            size: w * 0.06,
          ),
          SizedBox(width: w * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: w * 0.038,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: h * 0.003),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: w * 0.032,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
