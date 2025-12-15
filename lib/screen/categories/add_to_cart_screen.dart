import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/screen/categories/proceed_to_checkout_screen.dart';
import '../../widgets/top_header.dart';

class AddToCartScreen extends StatefulWidget {
  const AddToCartScreen({super.key, required String itemImage, required String itemPrice, required String itemName});

  @override
  State<AddToCartScreen> createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  int qty = 1;
  bool isDeleted = false;

  final int price = 450;
  final int deliveryCharge = 40;

  int get subTotal => price * qty;
  int get total => subTotal + deliveryCharge;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: SingleChildScrollView(
        child: Column(
          children: [
            const TopHeader(),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: mq.width * 0.04),
              child: Column(
                children: [
                  SizedBox(height: mq.height * 0.015),

                  /// BACK + TITLE
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back,
                            color: const Color(0xFF3670A3), size: mq.width * 0.06),
                        SizedBox(width: mq.width * 0.02),
                        Text(
                          "Shopping Cart",
                          style: TextStyle(
                            fontSize: mq.width * 0.045,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF3670A3),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: mq.height * 0.02),

                  /// CART ITEM (Only if not deleted)
                  if (!isDeleted)
                    Container(
                      padding: EdgeInsets.all(mq.width * 0.03),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(mq.width * 0.03),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(mq.width * 0.02),
                            child: Image.asset(
                              "assets/images/clothe.jpg",
                              height: mq.height * 0.10,
                              width: mq.width * 0.20,
                              fit: BoxFit.cover,
                            ),
                          ),

                          SizedBox(width: mq.width * 0.03),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Basmati Rice 5kg",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: mq.width * 0.04,
                                  ),
                                ),

                                SizedBox(height: mq.height * 0.005),

                                Row(
                                  children: [
                                    Text(
                                      "₹$subTotal",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                        fontSize: mq.width * 0.04,
                                      ),
                                    ),
                                    SizedBox(width: mq.width * 0.02),
                                    Text(
                                      "₹550",
                                      style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: mq.width * 0.03,
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: mq.height * 0.010),

                                Row(
                                  children: [
                                    qtyBtn(Icons.remove, mq, () {
                                      if (qty > 1) {
                                        setState(() => qty--);
                                      }
                                    }),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: mq.width * 0.025),
                                      child: Text(
                                        "$qty",
                                        style: TextStyle(fontSize: mq.width * 0.04),
                                      ),
                                    ),
                                    qtyBtn(Icons.add, mq, () {
                                      setState(() => qty++);
                                    }),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          /// DELETE BUTTON
                          InkWell(
                            onTap: () {
                              setState(() => isDeleted = true);
                            },
                            child: Icon(Icons.delete,
                                color: Colors.red, size: mq.width * 0.065),
                          ),
                        ],
                      ),
                    ),

                  SizedBox(height: mq.height * 0.02),

                  /// ORDER SUMMARY
                  Container(
                    padding: EdgeInsets.all(mq.width * 0.03),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(mq.width * 0.03),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order Summary",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: mq.width * 0.045,
                          ),
                        ),
                        SizedBox(height: mq.height * 0.01),

                        summaryRow("Items", qty.toString(), mq),
                        summaryRow("Subtotal", "₹$subTotal", mq),
                        summaryRow("Delivery", "₹$deliveryCharge", mq),

                        Divider(height: mq.height * 0.03),

                        summaryRow("Total", "₹$total", mq, isBold: true),
                      ],
                    ),
                  ),

                  SizedBox(height: mq.height * 0.03),

                  /// PROCEED BUTTON (Only if item not deleted)
                  if (!isDeleted)
                    SizedBox(
                      width: double.infinity,
                      height: mq.height * 0.055,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3670A3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(mq.width * 0.02),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProceedToCheckoutScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Proceed To Checkout",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: mq.width * 0.045,
                          ),
                        ),
                      ),
                    ),

                  SizedBox(height: mq.height * 0.04),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget summaryRow(String title, String value, Size mq, {bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: mq.height * 0.006),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: mq.width * 0.04)),
          Text(
            value,
            style: TextStyle(
              fontSize: mq.width * 0.04,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isBold ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget qtyBtn(IconData icon, Size mq, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: mq.width * 0.07,
        width: mq.width * 0.07,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(mq.width * 0.015),
        ),
        child: Icon(icon, size: mq.width * 0.04),
      ),
    );
  }
}
