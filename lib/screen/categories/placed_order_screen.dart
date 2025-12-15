import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/screen/categories/TrackOrderScreen.dart';
import '../../widgets/top_header.dart';
import '../../colors/AppColors.dart';

// PDF + Storage Packages
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';

class PlacedOrderScreen extends StatefulWidget {
  final String productName;
  final double totalAmount;
  final String paymentMethod;
  final String address;

  const PlacedOrderScreen({
    super.key,
    required this.productName,
    required this.totalAmount,
    required this.paymentMethod,
    required this.address,
  });

  @override
  State<PlacedOrderScreen> createState() => _PlacedOrderScreenState();
}

class _PlacedOrderScreenState extends State<PlacedOrderScreen> {
  int currentStep = 2; // Step tracking

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: Column(
        children: [
          const TopHeader(),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: mq.height * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ---------------- BACK BUTTON ----------------
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: mq.width * 0.04,
                        vertical: mq.height * 0.015),
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back, color: AppColors.primary),
                          SizedBox(width: mq.width * 0.02),
                          Text(
                            "Order Details",
                            style: TextStyle(
                              fontSize: mq.width * 0.048,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: mq.height * 0.01),

                  // ---------------- ORDER TRACKING ----------------
                  _buildBox(
                    mq,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order Tracking",
                          style: TextStyle(
                            fontSize: mq.width * 0.046,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: mq.height * 0.02),
                        flipkartTimeline(mq),
                      ],
                    ),
                  ),

                  SizedBox(height: mq.height * 0.02),

                  // ---------------- PRODUCT BOX ----------------
                  _buildBox(
                    mq,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: mq.width * 0.55,
                          child: Text(
                            widget.productName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: mq.width * 0.042,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Text(
                          "₹${widget.totalAmount}",
                          style: TextStyle(
                            fontSize: mq.width * 0.045,
                            fontWeight: FontWeight.bold,
                            color: AppColors.success,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: mq.height * 0.02),

                  // ---------------- DELIVERY DETAILS ----------------
                  _buildBox(
                    mq,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        detailText("Payment Method : ${widget.paymentMethod}", mq),
                        detailText("Delivery Address : ${widget.address}", mq),
                        SizedBox(height: mq.height * 0.02),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Order Total",
                              style: TextStyle(
                                  fontSize: mq.width * 0.045,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "₹${widget.totalAmount}",
                              style: TextStyle(
                                  fontSize: mq.width * 0.048,
                                  color: AppColors.success,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: mq.height * 0.03),

                  // ---------------- INVOICE + TRACK ORDER BUTTONS ----------------
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: mq.width * 0.03),
                    child: Row(
                      children: [
                        // ---------------- DOWNLOAD INVOICE ----------------
                        Expanded(
                          child: _mainButton(
                            mq,
                            label: "Download Invoice",
                            onTap: () {
                              generateInvoicePDF(
                                productName: widget.productName,
                                amount: widget.totalAmount,
                                paymentMethod: widget.paymentMethod,
                                address: widget.address,
                              );
                            },
                          ),
                        ),

                        SizedBox(width: mq.width * 0.03),

                        // ---------------- TRACK ORDER ----------------
                        Expanded(
                          child: _mainButton(
                            mq,
                            label: "Track Order",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => TrackOrderScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: mq.height * 0.02),

                  // ---------------- CANCEL ORDER ----------------
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: mq.width * 0.25),
                    child: SizedBox(
                      height: mq.height * 0.055,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: _showCancelOrderDialog,
                        child: Text(
                          "Cancel Order",
                          style: TextStyle(
                            fontSize: mq.width * 0.04,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: mq.height * 0.03),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // ----------------------------------------------------------------
  // 📌 MODERN BUTTON WIDGET
  // ----------------------------------------------------------------
  Widget _mainButton(Size mq, {required String label, required Function() onTap}) {
    return SizedBox(
      height: mq.height * 0.055,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2D6CA3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          shadowColor: Colors.black.withOpacity(0.3),
          elevation: 6,
        ),
        onPressed: onTap,
        child: Text(
          label,
          style: TextStyle(
              fontSize: mq.width * 0.04,
              fontWeight: FontWeight.w700,
              color: Colors.white),
        ),
      ),
    );
  }

  // ----------------------------------------------------------------
  // 📌 CANCEL ORDER POPUP
  // ----------------------------------------------------------------
  void _showCancelOrderDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text("Cancel Order"),
        content: const Text("Are you sure you want to cancel this order?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("No"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);
              _orderCancelledMessage();
            },
            child: const Text("Yes, Cancel"),
          ),
        ],
      ),
    );
  }

  void _orderCancelledMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: const Text(
          "Your order has been cancelled successfully!",
          style: TextStyle(fontSize: 16),
        ),
        duration: Duration(seconds: 2),
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  }

  // ----------------------------------------------------------------
  // 📌 PDF GENERATOR FUNCTION
  // ----------------------------------------------------------------
  Future<void> generateInvoicePDF({
    required String productName,
    required double amount,
    required String paymentMethod,
    required String address,
  }) async {
    try {
      var status = await Permission.storage.request();
      if (!status.isGranted) return;

      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("INVOICE",
                    style:
                    pw.TextStyle(fontSize: 30, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 20),
                pw.Text("Product: $productName", style: pw.TextStyle(fontSize: 18)),
                pw.Text("Amount: ₹$amount", style: pw.TextStyle(fontSize: 18)),
                pw.Text("Payment Method: $paymentMethod",
                    style: pw.TextStyle(fontSize: 18)),
                pw.Text("Delivery Address: $address",
                    style: pw.TextStyle(fontSize: 18)),
                pw.SizedBox(height: 20),
                pw.Text("Thank you for your order!",
                    style: pw.TextStyle(
                        fontSize: 18, fontWeight: pw.FontWeight.bold)),
              ],
            );
          },
        ),
      );

      final dir = await getExternalStorageDirectory();
      String filePath =
          "${dir!.path}/invoice_${DateTime.now().millisecondsSinceEpoch}.pdf";

      File file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      await OpenFile.open(filePath);
    } catch (e) {
      print("PDF ERROR: $e");
    }
  }

  // ----------------------------------------------------------------
  // TIMELINE
  // ----------------------------------------------------------------
  Widget flipkartTimeline(Size mq) {
    return Column(
      children: [
        trackingStep(mq, step: 1, title: "Ordered", date: "Today"),
        trackingStep(mq, step: 2, title: "Packed", date: "Processing"),
        trackingStep(mq, step: 3, title: "Shipped", date: "Pending"),
        trackingStep(mq, step: 4, title: "Delivery", date: "Pending"),
      ],
    );
  }

  Widget trackingStep(Size mq,
      {required int step, required String title, required String date}) {
    bool completed = currentStep >= step;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(
              completed ? Icons.check_circle : Icons.radio_button_unchecked,
              color: completed ? Colors.green : Colors.grey,
              size: mq.width * 0.065,
            ),
            if (step < 4)
              Container(
                width: 2,
                height: mq.height * 0.06,
                color: completed ? Colors.green : Colors.grey.shade400,
              ),
          ],
        ),
        SizedBox(width: mq.width * 0.04),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: mq.width * 0.04,
                fontWeight: completed ? FontWeight.w700 : FontWeight.w500,
                color: completed ? Colors.black : Colors.grey,
              ),
            ),
            SizedBox(height: mq.height * 0.005),
            Text(
              date,
              style: TextStyle(
                fontSize: mq.width * 0.033,
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: mq.height * 0.02),
          ],
        ),
      ],
    );
  }

  // ---------------- Common UI ----------------
  Widget _buildBox(Size mq, Widget child) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: mq.width * 0.03),
      padding: EdgeInsets.all(mq.width * 0.035),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(mq.width * 0.03),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget detailText(String text, Size mq) {
    return Padding(
      padding: EdgeInsets.only(bottom: mq.height * 0.008),
      child: Text(
        text,
        style: TextStyle(fontSize: mq.width * 0.04, color: AppColors.textDark),
      ),
    );
  }
}
