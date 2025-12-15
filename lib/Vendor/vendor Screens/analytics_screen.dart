import 'package:flutter/material.dart';
import '../../widgets/top_header.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final h = size.height;
    final w = size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const TopHeader(),

            // 🔙 BACK + TITLE + DOWNLOAD
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.03, vertical: h * 0.015),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back, size: w * 0.07),
                  ),
                  SizedBox(width: w * 0.025),

                  Text(
                    "Analytics & Reports",
                    style: TextStyle(
                      fontSize: w * 0.05,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const Spacer(),

                  Container(
                    padding: EdgeInsets.all(w * 0.02),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(w * 0.02),
                    ),
                    child: Icon(Icons.download, color: Colors.blue, size: w * 0.06),
                  )
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child: Text(
                "Track your store performance",
                style: TextStyle(fontSize: w * 0.035, color: Colors.black54),
              ),
            ),

            SizedBox(height: h * 0.02),

            // 🔥 TOP 4 SMALL CARDS
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _topSmallCard("₹45,850", "Total Sales", Icons.currency_rupee, h, w),
                  _topSmallCard("98", "Total Customers", Icons.people, h, w),
                  _topSmallCard("₹294", "Avg. Order", Icons.shopping_cart, h, w),
                  _topSmallCard("154", "Total Orders", Icons.list_alt, h, w),
                ],
              ),
            ),

            SizedBox(height: h * 0.02),

            // 📊 MONTHLY SALES CARD
            _whiteCard(
              h,
              w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Monthly Sales",
                      style: TextStyle(fontSize: w * 0.045, fontWeight: FontWeight.w700)),
                  SizedBox(height: h * 0.015),

                  _monthRow("Jan", "12,500", 0.45, h, w),
                  SizedBox(height: h * 0.012),
                  _monthRow("Feb", "15,800", 0.65, h, w),
                  SizedBox(height: h * 0.012),
                  _monthRow("March", "20,650", 0.90, h, w),
                ],
              ),
            ),

            SizedBox(height: h * 0.02),

            // 🛒 TOP SELLING PRODUCTS
            _whiteCard(
              h,
              w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Top Selling Products",
                      style: TextStyle(fontSize: w * 0.045, fontWeight: FontWeight.w700)),
                  SizedBox(height: h * 0.015),

                  _productRow("Basmati Rice 5kg", "45 units sold", "₹20,500", h, w),
                  Divider(height: h * 0.03),
                  _productRow("Cooking Oil 5L", "32 units sold", "₹19,165", h, w),
                ],
              ),
            ),

            SizedBox(height: h * 0.02),

            // 📈 PERFORMANCE SUMMARY
            _whiteCard(
              h,
              w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Performance Summary",
                      style: TextStyle(fontSize: w * 0.045, fontWeight: FontWeight.w700)),
                  SizedBox(height: h * 0.015),

                  _perfRow("Order Fulfillment Rate", "94%", 0.94, Colors.green, h, w),
                  SizedBox(height: h * 0.015),

                  _perfRow("Customer Satisfaction", "4.6/5", 0.92, Colors.green, h, w),
                  SizedBox(height: h * 0.015),

                  _perfRow("Response Time", "2.3 hrs", 0.40, Colors.blue, h, w),
                ],
              ),
            ),

            SizedBox(height: h * 0.10),
          ],
        ),
      ),
    );
  }

  // 🔹 Top Small Cards
  Widget _topSmallCard(String value, String title, IconData icon, double h, double w) {
    return Container(
      width: w * 0.22,
      padding: EdgeInsets.symmetric(vertical: h * 0.015),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(w * 0.025),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: w * 0.02,
            spreadRadius: w * 0.005,
          )
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.blue, size: w * 0.07),
          SizedBox(height: h * 0.008),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: w * 0.038)),
          Text(title, style: TextStyle(fontSize: w * 0.03, color: Colors.black54)),
        ],
      ),
    );
  }

  // 🔹 White Card
  Widget _whiteCard(double h, double w, {required Widget child}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.03),
      child: Container(
        padding: EdgeInsets.all(w * 0.035),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(w * 0.03),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: w * 0.03,
              spreadRadius: w * 0.01,
            )
          ],
        ),
        child: child,
      ),
    );
  }

  // 🔹 Monthly Row
  Widget _monthRow(String month, String value, double progress, double h, double w) {
    return Column(
      children: [
        Row(
          children: [
            Text(month, style: TextStyle(fontSize: w * 0.038)),
            const Spacer(),
            Text("₹$value", style: TextStyle(fontSize: w * 0.038)),
          ],
        ),
        SizedBox(height: h * 0.005),
        LinearProgressIndicator(
          value: progress,
          minHeight: h * 0.009,
          borderRadius: BorderRadius.circular(w * 0.02),
          color: Colors.blue,
          backgroundColor: Colors.grey.shade300,
        )
      ],
    );
  }

  // 🔹 Product Row
  Widget _productRow(String product, String units, String price, double h, double w) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: w * 0.04)),
            Text(units, style: TextStyle(fontSize: w * 0.03, color: Colors.black54)),
          ],
        ),
        const Spacer(),
        Text(
          price,
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.w700, fontSize: w * 0.04),
        ),
      ],
    );
  }

  // 🔹 Performance Row
  Widget _perfRow(String title, String result, double progress, Color color, double h, double w) {
    return Column(
      children: [
        Row(
          children: [
            Text(title, style: TextStyle(fontSize: w * 0.038)),
            const Spacer(),
            Text(
              result,
              style: TextStyle(color: color, fontSize: w * 0.04, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: h * 0.005),
        LinearProgressIndicator(
          value: progress,
          minHeight: h * 0.009,
          borderRadius: BorderRadius.circular(w * 0.02),
          color: color,
          backgroundColor: Colors.grey.shade300,
        )
      ],
    );
  }
}
