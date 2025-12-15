import 'package:flutter/material.dart';

class DashboardProvider extends ChangeNotifier {
  double totalSales = 45850;
  int totalProducts = 34;
  int pendingOrders = 10;
  int totalOrders = 156;

  List<Map<String, dynamic>> recentOrders = [
    {
      "orderId": "ORD001",
      "name": "Rahul Kumar",
      "items": "3 Items",
      "amount": "₹850",
      "status": "Pending",
      "color": Colors.orange
    },
    {
      "orderId": "ORD002",
      "name": "Priya Singh",
      "items": "3 Items",
      "amount": "₹1200",
      "status": "Packed",
      "color": Colors.blue
    },
    {
      "orderId": "ORD003",
      "name": "Sneha Patel",
      "items": "3 Items",
      "amount": "₹980",
      "status": "Delivered",
      "color": Colors.green
    },
  ];

  List<Map<String, dynamic>> lowStock = [
    {"title": "Basmati Rice 5kg", "left": "5"},
    {"title": "Cooking Oil 5L", "left": "3"},
    {"title": "Sugar 5kg", "left": "7"},
  ];

  // Update Dashboard data (future API)
  void updateData({
    double? sales,
    int? products,
    int? pending,
    int? orders,
  }) {
    if (sales != null) totalSales = sales;
    if (products != null) totalProducts = products;
    if (pending != null) pendingOrders = pending;
    if (orders != null) totalOrders = orders;
    notifyListeners();
  }
}
