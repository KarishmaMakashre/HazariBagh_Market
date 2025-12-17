import 'package:flutter/material.dart';
import '../../widgets/top_header.dart';

class ViewStoreScreen extends StatelessWidget {
  const ViewStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [
            const TopHeader(),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: 10),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                      color: const Color(0xFF3670A3),
                      size: w * 0.06,
                    ),
                  ),
                  SizedBox(width: w * 0.02),
                  Text(
                    "Stores",
                    style: TextStyle(
                      fontSize: w * 0.045,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF3670A3),
                    ),
                  ),
                ],
              ),
            ),

            /// 🔥 GRID LIST
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(w * 0.04),
                itemCount: 8,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: w * 0.04,
                  crossAxisSpacing: w * 0.04,
                  childAspectRatio: 0.75, // 🔥 important
                ),
                itemBuilder: (context, index) {
                  return storeCard(w);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🟦 STORE CARD (NO OVERFLOW GUARANTEED)
  Widget storeCard(double w) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // 🔥 OVERFLOW FIX
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// IMAGE
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
            child: Image.asset(
              "assets/images/clothe.jpg",
              height: 110,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min, // 🔥 FIX
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Fashion Store",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: w * 0.038,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  "Main Market, Hazaribagh",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: w * 0.032,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 6),

                Row(
                  children: const [
                    Icon(Icons.star, color: Colors.orange, size: 16),
                    SizedBox(width: 4),
                    Text(
                      "4.5",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
