import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hazari_bagh_market/screen/categories/placed_order_screen.dart';
import '../../provider/cart_provider.dart';
import '../../widgets/top_header.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  int selectedPayment = 0; // 0=COD, 1=UPI, 2=CARD

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final cart = Provider.of<CartProvider>(context);

    // Delivery Fee Already Updated During Checkout Screen
    double deliveryFee = cart.deliveryFee;
    double subtotal = cart.subtotal;
    double totalAmount = subtotal + deliveryFee;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TopHeader(),

            // BACK + TITLE
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: mq.width * 0.04,
                vertical: mq.height * 0.01,
              ),
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: const Color(0xFF3670A3),
                      size: mq.width * 0.06,
                    ),
                    SizedBox(width: mq.width * 0.02),
                    Text(
                      "Payment Method",
                      style: TextStyle(
                        fontSize: mq.width * 0.045,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF3670A3),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: mq.height * 0.02),

            // CASH ON DELIVERY
            Padding(
              padding: EdgeInsets.symmetric(horizontal: mq.width * 0.03),
              child: paymentTile(
                mq: mq,
                title: "Cash On Delivery",
                subtitle: "Pay When You Receive",
                icon: Icons.payments,
                isSelected: selectedPayment == 0,
                onTap: () => setState(() => selectedPayment = 0),
              ),
            ),

            SizedBox(height: mq.height * 0.015),

            // UPI PAYMENT
            Padding(
              padding: EdgeInsets.symmetric(horizontal: mq.width * 0.03),
              child: paymentTile(
                mq: mq,
                title: "UPI Payment",
                subtitle: "Pay Via Google Pay, PhonePe, Paytm",
                icon: Icons.qr_code,
                isSelected: selectedPayment == 1,
                onTap: () => setState(() => selectedPayment = 1),
              ),
            ),

            SizedBox(height: mq.height * 0.015),

            // CARD PAYMENT
            Padding(
              padding: EdgeInsets.symmetric(horizontal: mq.width * 0.03),
              child: paymentTile(
                mq: mq,
                title: "Debit / Credit Card",
                subtitle: "Visa, Mastercard, Rupay",
                icon: Icons.credit_card,
                isSelected: selectedPayment == 2,
                onTap: () => setState(() => selectedPayment = 2),
              ),
            ),

            SizedBox(height: mq.height * 0.025),

            // ORDER SUMMARY BOX
            Padding(
              padding: EdgeInsets.symmetric(horizontal: mq.width * 0.03),
              child: Container(
                padding: EdgeInsets.all(mq.width * 0.03),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(mq.width * 0.03),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    summaryRow(
                      mq: mq,
                      title: "Subtotal (${cart.cartCount} Items)",
                      value: "₹$subtotal",
                    ),
                    SizedBox(height: mq.height * 0.008),
                    summaryRow(mq: mq, title: "Delivery Fees", value: "₹$deliveryFee"),
                    Divider(),
                    summaryRow(
                      mq: mq,
                      title: "Total",
                      value: "₹$totalAmount",
                      isBold: true,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: mq.height * 0.03),

            // BUTTONS
            Padding(
              padding: EdgeInsets.symmetric(horizontal: mq.width * 0.03),
              child: Row(
                children: [
                  // BACK BUTTON
                  Expanded(
                    child: SizedBox(
                      height: mq.height * 0.055,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade300,
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "Back",
                          style: TextStyle(
                              fontSize: mq.width * 0.04,
                              color: Colors.black87),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: mq.width * 0.03),

                  // PLACE ORDER BUTTON
                  // PLACE ORDER BUTTON
                  Expanded(
                    child: SizedBox(
                      height: mq.height * 0.055,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3670A3),
                        ),
                        onPressed: () {
                          String paymentType = selectedPayment == 0
                              ? "Cash On Delivery"
                              : selectedPayment == 1
                              ? "UPI Payment"
                              : "Card Payment";

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlacedOrderScreen(
                                productName: cart.cartItems.isNotEmpty
                                    ? cart.cartItems.first["name"] ?? "Product"
                                    : "Product",

                                totalAmount: totalAmount,

                                // ✔ Correct Payment Method Passing
                                paymentMethod: selectedPayment == 0
                                    ? "Cash On Delivery"
                                    : selectedPayment == 1
                                    ? "UPI Payment"
                                    : "Card Payment",

                                // ✔ Safe address handling
                                address: cart.selectedAddress ?? "No Address Found",
                              ),
                            ),
                          );



                        },
                        child: Text(
                          "Place Order",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: mq.width * 0.04,
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),

            SizedBox(height: mq.height * 0.03),
          ],
        ),
      ),
    );
  }

  // PAYMENT OPTION BOX
  Widget paymentTile({
    required Size mq,
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(mq.width * 0.03),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey.shade300,
            width: mq.width * 0.003,
          ),
          borderRadius: BorderRadius.circular(mq.width * 0.03),
        ),
        child: Row(
          children: [
            Icon(icon, size: mq.width * 0.065),
            SizedBox(width: mq.width * 0.03),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: mq.width * 0.04),
                  ),
                  SizedBox(height: mq.height * 0.005),
                  Text(
                    subtitle,
                    style: TextStyle(
                        fontSize: mq.width * 0.032, color: Colors.black54),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle,
                  color: Colors.green, size: mq.width * 0.06),
          ],
        ),
      ),
    );
  }

  // SUMMARY ROW
  Widget summaryRow({
    required Size mq,
    required String title,
    required String value,
    bool isBold = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: mq.height * 0.005),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: mq.width * 0.038,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: mq.width * 0.04,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
              color: isBold ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
