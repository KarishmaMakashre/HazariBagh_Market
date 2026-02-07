// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../VendorProvider/grocery_store_provider.dart';
//
// class GroceryStoreScreen extends StatelessWidget {
//   const GroceryStoreScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<GroceryStoreProvider>();
//
//     return Scaffold(
//       appBar: AppBar(title: const Text("Grocery Store")),
//       body: ListView.builder(
//         padding: const EdgeInsets.all(12),
//         itemCount: provider.products.length,
//         itemBuilder: (context, index) {
//           final p = provider.products[index];
//
//           return Card(
//             margin: const EdgeInsets.only(bottom: 12),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: Row(
//                 children: [
//                   // IMAGE
//                   Container(
//                     height: 80,
//                     width: 80,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       color: Colors.grey.shade200,
//                     ),
//                     child: Image.network(
//                       "https://api.hazaribagmarket.in/${p.images.first}",
//                       fit: BoxFit.cover,
//                       errorBuilder: (_, __, ___) =>
//                       const Icon(Icons.image),
//                     ),
//                   ),
//
//                   const SizedBox(width: 12),
//
//                   // DETAILS
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           p.name,
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(p.description),
//
//                         const SizedBox(height: 6),
//
//                         Text(
//                           "₹${p.sellingPrice}",
//                           style: const TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           "MRP ₹${p.mrp} • ${p.discountPercentage}% OFF",
//                           style: const TextStyle(
//                             fontSize: 12,
//                             decoration: TextDecoration.lineThrough,
//                             color: Colors.grey,
//                           ),
//                         ),
//
//                         const SizedBox(height: 6),
//
//                         Text(
//                           "Stock: ${p.stock} ${p.unit}",
//                           style: const TextStyle(fontSize: 12),
//                         ),
//                         Text(
//                           "${p.category} • ${p.subCategory}",
//                           style: const TextStyle(
//                             fontSize: 12,
//                             color: Colors.grey,
//                           ),
//                         ),
//                         Text(
//                           "Vendor: ${p.vendorName}",
//                           style: const TextStyle(
//                             fontSize: 12,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
