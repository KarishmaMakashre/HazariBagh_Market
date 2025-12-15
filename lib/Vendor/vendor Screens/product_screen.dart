// import 'package:flutter/material.dart';
// import '../../widgets/top_header.dart';
// import 'add_new_product_screen.dart';
// import 'vendor_dashboard_home_screen.dart';
//
// class ProductsScreen extends StatelessWidget {
//   const ProductsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final w = size.width;
//     final h = size.height;
//
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const TopHeader(),
//           SizedBox(height: h * 0.01),
//
//           // ---------------- TITLE + ADD BUTTON ----------------
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: w * 0.04),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (_) => const DashboardHomeScreen()),
//                         );
//                       },
//                       child: Icon(Icons.arrow_back, size: w * 0.065),
//                     ),
//                     SizedBox(width: w * 0.02),
//                     Text(
//                       "Products",
//                       style: TextStyle(
//                         fontSize: w * 0.06,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (_) => const AddNewProductScreen()),
//                     );
//                   },
//                   child: Container(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: w * 0.03, vertical: h * 0.01),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF3670A3),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Text(
//                       "+ Add New Products & Service",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: w * 0.035,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           SizedBox(height: h * 0.008),
//
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: w * 0.04),
//             child: Text(
//               "Manage Your Inventory.",
//               style: TextStyle(
//                 fontSize: w * 0.035,
//                 color: Colors.black54,
//               ),
//             ),
//           ),
//
//           SizedBox(height: h * 0.015),
//
//           // ---------------- PRODUCT GRID ----------------
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: w * 0.03),
//               child: GridView.builder(
//                 itemCount: 6,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: w < 600 ? 2 : 3,   // 📌 Responsive Grid
//                   mainAxisExtent: h * 0.33,
//                   crossAxisSpacing: w * 0.03,
//                   mainAxisSpacing: h * 0.02,
//                 ),
//                 itemBuilder: (context, index) {
//                   return productCard(
//                     w: w,
//                     h: h,
//                     name: "Basmati Rice 5kg",
//                     price: "₹600",
//                     oldPrice: "₹650",
//                     stock: "45 units",
//                     isLowStock: index == 2,
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ---------------- PRODUCT CARD ----------------
//   Widget productCard({
//     required double w,
//     required double h,
//     required String name,
//     required String price,
//     required String oldPrice,
//     required String stock,
//     bool isLowStock = false,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 6,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // ---------------- IMAGE ----------------
//           Stack(
//             children: [
//               Container(
//                 height: h * 0.14,
//                 decoration: BoxDecoration(
//                   borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
//                   image: const DecorationImage(
//                     image: AssetImage("assets/images/electronics.jpg"),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//
//               if (isLowStock)
//                 Positioned(
//                   top: 8,
//                   left: 8,
//                   child: Container(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: w * 0.02, vertical: h * 0.003),
//                     decoration: BoxDecoration(
//                       color: Colors.red.shade600,
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                     child: Text(
//                       "Low Stock",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: w * 0.03,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//
//           // ---------------- DETAILS ----------------
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: w * 0.03, vertical: h * 0.007),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(name,
//                     style: TextStyle(fontSize: w * 0.035, fontWeight: FontWeight.w600)),
//                 SizedBox(height: h * 0.005),
//
//                 Row(
//                   children: [
//                     Text(price,
//                         style: TextStyle(fontSize: w * 0.035, color: Colors.black87)),
//                     SizedBox(width: w * 0.01),
//                     Text(
//                       oldPrice,
//                       style: TextStyle(
//                         color: Colors.grey,
//                         fontSize: w * 0.03,
//                         decoration: TextDecoration.lineThrough,
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 SizedBox(height: h * 0.005),
//                 Text(
//                   "Stock: $stock",
//                   style: TextStyle(fontSize: w * 0.03, color: Colors.green),
//                 ),
//               ],
//             ),
//           ),
//
//           const Spacer(),
//
//           // ---------------- EDIT & DELETE ----------------
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: w * 0.03, vertical: h * 0.01),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     padding: EdgeInsets.symmetric(vertical: h * 0.012),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF3670A3),
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     alignment: Alignment.center,
//                     child: Text(
//                       "Edit",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: w * 0.035,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: w * 0.03),
//
//                 Container(
//                   padding: EdgeInsets.all(w * 0.02),
//                   decoration: BoxDecoration(
//                     color: Colors.red.shade400,
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                   child: Icon(Icons.delete, color: Colors.white, size: w * 0.045),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
