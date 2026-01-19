import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../widget/vendor_top_header.dart';

class VendorDashboardScreen extends StatefulWidget {
  const VendorDashboardScreen({super.key});

  @override
  State<VendorDashboardScreen> createState() =>
      _VendorDashboardScreenState();
}

class _VendorDashboardScreenState extends State<VendorDashboardScreen> {
  bool isOnline = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
        isDark ? Brightness.light : Brightness.dark,
      ),
    );

    final bgColor =
    isDark ? const Color(0xFF0F172A) : const Color(0xFFF6F8FC);
    final cardColor =
    isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor =
    isDark ? Colors.white : const Color(0xFF1F2937);
    final subTextColor =
    isDark ? Colors.grey.shade400 : Colors.grey.shade600;
    final shadowColor =
    isDark ? Colors.black.withOpacity(0.35) : Colors.black.withOpacity(0.08);

    return Scaffold(backgroundColor: bgColor,

      body: SingleChildScrollView(
        padding: EdgeInsets.all(w * 0.045),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome Back 👋",
              style: TextStyle(
                fontSize: w * 0.052,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            SizedBox(height: h * 0.006),
            Text(
              "Here is your business overview",
              style: TextStyle(
                fontSize: w * 0.035,
                color: subTextColor,
              ),
            ),

            SizedBox(height: h * 0.02),

            /// ONLINE / OFFLINE
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isOnline ? "Status: Online" : "Status: Offline",
                  style: TextStyle(
                    fontSize: w * 0.038,
                    fontWeight: FontWeight.w600,
                    color: isOnline ? Colors.green : Colors.red,
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() => isOnline = !isOnline),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 64,
                    height: 34,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: isOnline
                          ? Colors.green
                          : Colors.grey.shade400,
                    ),
                    child: Align(
                      alignment: isOnline
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        width: 26,
                        height: 26,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: h * 0.03),

            Row(
              children: [
                _statCard(w,
                    title: "Orders",
                    value: "24",
                    icon: Icons.shopping_cart,
                    color: Colors.blue,
                    cardColor: cardColor,
                    textColor: textColor,
                    subTextColor: subTextColor,
                    shadowColor: shadowColor),
                _statCard(w,
                    title: "Revenue",
                    value: "₹1.2k",
                    icon: Icons.currency_rupee,
                    color: Colors.green,
                    cardColor: cardColor,
                    textColor: textColor,
                    subTextColor: subTextColor,
                    shadowColor: shadowColor),
              ],
            ),

            SizedBox(height: h * 0.04),

            Text(
              "Weekly Sales",
              style: TextStyle(
                fontSize: w * 0.046,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),

            SizedBox(height: h * 0.02),

            Container(
              height: h * 0.28,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(color: shadowColor, blurRadius: 6),
                ],
              ),
              child: BarChart(_barChartData()),
            ),
          ],
        ),
      ),
    );
  }

  static BarChartData _barChartData() {
    final values = [1800.0, 2200.0, 1500.0, 3200.0, 2800.0, 4100.0, 3600.0];

    return BarChartData(
      maxY: 5000,
      gridData: FlGridData(show: false),
      borderData: FlBorderData(show: false),
      barGroups: List.generate(
        values.length,
            (i) => BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: values[i],
              width: 18,
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  static Widget _statCard(
      double w, {
        required String title,
        required String value,
        required IconData icon,
        required Color color,
        required Color cardColor,
        required Color textColor,
        required Color subTextColor,
        required Color shadowColor,
      }) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: w * 0.01),
        padding: EdgeInsets.all(w * 0.03),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(color: shadowColor, blurRadius: 6),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 8),
            Text(value,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: textColor)),
            Text(title,
                style: TextStyle(
                    fontSize: 12, color: subTextColor)),
          ],
        ),
      ),
    );
  }
}
