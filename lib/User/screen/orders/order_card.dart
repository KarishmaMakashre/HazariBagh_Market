import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';

class OrderCard extends StatelessWidget {
  final String orderId;
  final String date;
  final String productKey;
  final int qty;
  final String price;
  final String statusKey;
  final Color statusColor;
  final String image;

  const OrderCard({
    super.key,
    required this.orderId,
    required this.date,
    required this.productKey,
    required this.qty,
    required this.price,
    required this.statusKey,
    required this.statusColor,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    final mq = MediaQuery.of(context);
    final w = mq.size.width;
    final h = mq.size.height;

    return Container(
      margin: EdgeInsets.only(bottom: h * 0.015),
      padding: EdgeInsets.all(w * 0.035),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(w * 0.035),
      ),
      child: Row(
        children: [

          /// 🔥 PRODUCT IMAGE
          Image.asset(
            image,
            width: w * 0.15,
            height: w * 0.15,
            fit: BoxFit.cover,
          ),

          SizedBox(width: w * 0.035),

          /// 🔥 DETAILS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  loc.getByKey(productKey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: w * 0.040,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: h * 0.004),

                Text(
                  "${loc.placedOn}: $date",
                  style: TextStyle(
                    fontSize: w * 0.032,
                    color: Colors.grey.shade600,
                  ),
                ),

                SizedBox(height: h * 0.004),

                Text(
                  "${loc.qty}: $qty • $price",
                  style: TextStyle(
                    fontSize: w * 0.034,
                  ),
                ),
              ],
            ),
          ),

          /// 🔥 STATUS CHIP
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: w * 0.03,
              vertical: h * 0.006,
            ),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(w * 0.05),
            ),
            child: Text(
              loc.getByKey(statusKey),
              style: TextStyle(
                color: statusColor,
                fontSize: w * 0.03,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
