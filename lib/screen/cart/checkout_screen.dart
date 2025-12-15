import 'package:flutter/material.dart';

import '../categories/payment_method_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool homeDelivery = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: Column(
        children: [
          // ✅ TOP BAR
          Container(
            color: const Color(0xFF3670A3),
            padding: const EdgeInsets.all(14),
            child: SafeArea(
              child: Row(
                children: const [
                  Text(
                    "Proceed To Checkout",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Icon(Icons.notifications, color: Colors.white),
                  SizedBox(width: 12),
                  Icon(Icons.person, color: Colors.white),
                ],
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ✅ BACK + TITLE
                  Row(
                    children: const [
                      Icon(Icons.arrow_back, size: 20),
                      SizedBox(width: 8),
                      Text("Delivery Details",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // ✅ HOME DELIVERY
                  deliveryOption(
                    selected: homeDelivery,
                    icon: Icons.location_on,
                    title: "Home Delivery",
                    subtitle: "Get It Delivered To Your Doorstep",
                    onTap: () {
                      setState(() => homeDelivery = true);
                    },
                  ),

                  const SizedBox(height: 12),

                  // ✅ STORE PICKUP
                  deliveryOption(
                    selected: !homeDelivery,
                    icon: Icons.store,
                    title: "Store Pickup",
                    subtitle: "Collect From Store - No Delivery Fee",
                    onTap: () {
                      setState(() => homeDelivery = false);
                    },
                  ),

                  const SizedBox(height: 24),

                  // ✅ DELIVERY ADDRESS
                  const Text(
                    "Delivery Address",
                    style:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  TextField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText:
                      "Enter Your Complete Delivery Address...",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ✅ BUTTONS
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade400,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Back To Cart"),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            const Color(0xFF3670A3),
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> PaymentMethodScreen()));
                          },
                          child: const Text("Continue"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ DELIVERY OPTION WIDGET
  Widget deliveryOption({
    required bool selected,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: selected ? Colors.blue.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? Colors.blue : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                  Text(subtitle,
                      style:
                      const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),

            if (selected)
              const Icon(Icons.check_circle, color: Colors.green),
          ],
        ),
      ),
    );
  }
}
