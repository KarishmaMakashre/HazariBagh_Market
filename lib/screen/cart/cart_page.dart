import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/widgets/top_header.dart';
import 'package:provider/provider.dart';
import '../../provider/cart_provider.dart';
import '../../colors/AppColors.dart';
import '../categories/proceed_to_checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.bgLight,

      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.cartItems.isEmpty) {
            return Center(
              child: Text(
                "Your cart is empty",
                style: TextStyle(
                  fontSize: mq.width * 0.05,
                  color: AppColors.textGrey,
                ),
              ),
            );
          }

          return Column(
            children: [
              const TopHeader(),

              // =====================
              // CART ITEMS LIST
              // =====================
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(mq.width * 0.03),
                  itemCount: cart.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cart.cartItems[index];

                    return Container(
                      margin: EdgeInsets.only(bottom: mq.height * 0.015),
                      padding: EdgeInsets.all(mq.width * 0.03),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(mq.width * 0.03),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadow,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// IMAGE
                              ClipRRect(
                                borderRadius: BorderRadius.circular(mq.width * 0.02),
                                child: Image.asset(
                                  item["image"],
                                  width: mq.width * 0.20,
                                  height: mq.width * 0.20,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              SizedBox(width: mq.width * 0.03),

                              /// ITEM DETAILS
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item["name"],
                                      style: TextStyle(
                                        fontSize: mq.width * 0.04,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textDark,
                                      ),
                                    ),

                                    SizedBox(height: mq.height * 0.005),

                                    Text(
                                      "Fashion Hub",
                                      style: TextStyle(
                                        fontSize: mq.width * 0.03,
                                        color: AppColors.textGrey,
                                      ),
                                    ),

                                    SizedBox(height: mq.height * 0.008),

                                    Row(
                                      children: [
                                        Text(
                                          "₹${item["price"]}",
                                          style: TextStyle(
                                            fontSize: mq.width * 0.042,
                                            color: AppColors.success,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: mq.width * 0.02),
                                        Text(
                                          "₹550",
                                          style: TextStyle(
                                            fontSize: mq.width * 0.032,
                                            color: AppColors.textGrey,
                                            decoration:
                                            TextDecoration.lineThrough,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),

                          SizedBox(height: mq.height * 0.015),

                          /// QTY BUTTONS + REMOVE
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /// QTY CONTROL
                              Row(
                                children: [
                                  _qtyButton(
                                    mq: mq,
                                    icon: Icons.remove,
                                    onTap: () {
                                      Provider.of<CartProvider>(context, listen: false)
                                          .decreaseQty(index);
                                    },
                                  ),

                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: mq.width * 0.04),
                                    child: Text(
                                      "${item["qty"]}",
                                      style: TextStyle(
                                        fontSize: mq.width * 0.045,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textDark,
                                      ),
                                    ),
                                  ),

                                  _qtyButton(
                                    mq: mq,
                                    icon: Icons.add,
                                    onTap: () {
                                      Provider.of<CartProvider>(context, listen: false)
                                          .increaseQty(index);
                                    },
                                  ),
                                ],
                              ),

                              /// REMOVE BUTTON
                              GestureDetector(
                                onTap: () {
                                  Provider.of<CartProvider>(context, listen: false)
                                      .removeItem(index);
                                },
                                child: Text(
                                  "Remove",
                                  style: TextStyle(
                                    color: AppColors.error,
                                    fontSize: mq.width * 0.035,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // =====================
              // ORDER SUMMARY
              // =====================
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(mq.width * 0.04),
                margin: EdgeInsets.symmetric(horizontal: mq.width * 0.03),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(mq.width * 0.03),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadow,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order Summary",
                      style: TextStyle(
                        fontSize: mq.width * 0.045,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),

                    SizedBox(height: mq.height * 0.015),

                    _summaryRow(
                      mq,
                      "Subtotal ( ${cart.cartItems.length} Items )",
                      "₹${cart.subtotal.toStringAsFixed(0)}",
                    ),

                    _summaryRow(mq, "Delivery Fees", "₹40"),

                    Divider(height: mq.height * 0.03),

                    _summaryRow(
                      mq,
                      "Total",
                      "₹${(cart.subtotal + 40).toStringAsFixed(0)}",
                      isBold: true,
                      color: AppColors.success,
                    ),
                  ],
                ),
              ),

              SizedBox(height: mq.height * 0.02),

              /// PROCEED BUTTON
              Padding(
                padding: EdgeInsets.symmetric(horizontal: mq.width * 0.03),
                child: SizedBox(
                  width: double.infinity,
                  height: mq.height * 0.065,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(mq.width * 0.02),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProceedToCheckoutScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Proceed To Checkout",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: mq.width * 0.045,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: mq.height * 0.02),
            ],
          );
        },
      ),
    );
  }

  /// 🔘 Quantity Button (THEMED + RESPONSIVE)
  Widget _qtyButton({
    required Size mq,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(mq.width * 0.02),
        color: AppColors.white,
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(mq.width * 0.015),
          child: Icon(
            icon,
            size: mq.width * 0.045,
            color: AppColors.textDark,
          ),
        ),
      ),
    );
  }

  /// 🔹 Summary Row
  Widget _summaryRow(Size mq, String title, String value,
      {bool isBold = false, Color color = AppColors.textDark}) {
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
              color: AppColors.textDark,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: mq.width * 0.040,
              color: color,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
