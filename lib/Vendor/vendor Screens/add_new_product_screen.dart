import 'package:flutter/material.dart';
import '../../widgets/top_header.dart';

class AddNewProductScreen extends StatelessWidget {
  const AddNewProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final h = mq.height;
    final w = mq.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const TopHeader(),
            SizedBox(height: h * 0.01),

            // 🔙 BACK + TITLE
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back, size: w * 0.065),
                  ),
                  SizedBox(width: w * 0.03),
                  Text(
                    "Add New Products / Service",
                    style: TextStyle(
                      fontSize: w * 0.05,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: h * 0.02),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // ✔ PRODUCT NAME
                  Text("Product/ Service Name", style: TextStyle(fontSize: w * 0.038)),
                  SizedBox(height: h * 0.005),
                  _textField("Enter product name", h, w),

                  SizedBox(height: h * 0.018),

                  // ✔ CATEGORY DROPDOWN
                  Text("Category", style: TextStyle(fontSize: w * 0.038)),
                  SizedBox(height: h * 0.005),
                  _dropdownBox("Select Category", h, w),

                  SizedBox(height: h * 0.018),

                  // ✔ MRP & OFFER PRICE
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("MRP", style: TextStyle(fontSize: w * 0.038)),
                            SizedBox(height: h * 0.005),
                            _numberField("0", h, w),
                          ],
                        ),
                      ),

                      SizedBox(width: w * 0.04),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Offer Price", style: TextStyle(fontSize: w * 0.038)),
                            SizedBox(height: h * 0.005),
                            _numberField("0", h, w),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: h * 0.018),

                  // ✔ STOCK
                  Text("Stock Quantity & Services", style: TextStyle(fontSize: w * 0.038)),
                  SizedBox(height: h * 0.005),
                  _textField("Enter stock quantity", h, w),

                  SizedBox(height: h * 0.02),

                  // ✔ IMAGES UPDATE
                  Text("Images Update", style: TextStyle(fontSize: w * 0.038)),
                  SizedBox(height: h * 0.008),

                  Row(
                    children: [
                      _imageBox(h, w),
                      SizedBox(width: w * 0.03),
                      _imageBox(h, w),
                      SizedBox(width: w * 0.03),
                      _imageBox(h, w),
                    ],
                  ),

                  SizedBox(height: h * 0.02),

                  // ✔ DESCRIPTION
                  Text("Description", style: TextStyle(fontSize: w * 0.038)),
                  SizedBox(height: h * 0.005),
                  Container(
                    height: h * 0.15,
                    padding: EdgeInsets.all(w * 0.03),
                    decoration: _decoration(w),
                    child: const TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter description",
                      ),
                    ),
                  ),

                  SizedBox(height: h * 0.02),

                  Center(
                    child: Text(
                      "Products require admin approval before appearing\nin the store.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: w * 0.035,
                      ),
                    ),
                  ),

                  SizedBox(height: h * 0.03),

                  // BUTTONS
                  Row(
                    children: [
                      // Cancel
                      Expanded(
                        child: Container(
                          height: h * 0.055,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(w * 0.02),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: w * 0.04,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: w * 0.04),

                      // Add Product
                      Expanded(
                        child: Container(
                          height: h * 0.055,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(w * 0.02),
                          ),
                          child: Text(
                            "Add Product",
                            style: TextStyle(
                              fontSize: w * 0.04,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: h * 0.12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Normal TextField
  Widget _textField(String hint, double h, double w) {
    return Container(
      height: h * 0.055,
      padding: EdgeInsets.symmetric(horizontal: w * 0.03),
      decoration: _decoration(w),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(fontSize: w * 0.035),
        ),
      ),
    );
  }

  // 🔹 Number TextField
  Widget _numberField(String hint, double h, double w) {
    return Container(
      height: h * 0.055,
      padding: EdgeInsets.symmetric(horizontal: w * 0.03),
      decoration: _decoration(w),
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(fontSize: w * 0.035),
        ),
      ),
    );
  }

  // 🔹 Dropdown Box
  Widget _dropdownBox(String text, double h, double w) {
    return Container(
      height: h * 0.055,
      padding: EdgeInsets.symmetric(horizontal: w * 0.03),
      decoration: _decoration(w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: TextStyle(color: Colors.black54, fontSize: w * 0.035)),
          Icon(Icons.keyboard_arrow_down, size: w * 0.06),
        ],
      ),
    );
  }

  // 🔹 Image Box
  Widget _imageBox(double h, double w) {
    return Container(
      height: h * 0.075,
      width: w * 0.16,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(w * 0.02),
        border: Border.all(color: Colors.grey.shade400),
        color: Colors.white,
      ),
      child: Icon(Icons.add, color: Colors.grey, size: w * 0.07),
    );
  }

  // 🔹 Box Decoration
  BoxDecoration _decoration(double w) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(w * 0.02),
      border: Border.all(color: Colors.grey.shade400),
    );
  }
}
