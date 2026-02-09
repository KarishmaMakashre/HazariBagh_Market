import 'package:flutter/material.dart';
import '../models/order_model.dart';

class OrderProvider extends ChangeNotifier {
  final List<OrderModel> _orders = [
    OrderModel(
      orderId: "ORD-1001",
      customer: "Rahul Sharma",
      amount: "₹1,250",
      status: "Pending",
    ),
    OrderModel(
      orderId: "ORD-1002",
      customer: "Anita Verma",
      amount: "₹3,499",
      status: "Delivered",
    ),
    OrderModel(
      orderId: "ORD-1003",
      customer: "Amit Patel",
      amount: "₹799",
      status: "Rejected",
    ),
    OrderModel(
      orderId: "ORD-1004",
      customer: "Priya Singh",
      amount: "₹2,150",
      status: "Pending",
    ),
  ];

  /// GET ORDERS
  List<OrderModel> get orders => _orders;

  /// ACCEPT ORDER
  void acceptOrder(int index) {
    _orders[index] = _orders[index].copyWith(
      status: "Delivered",
    );
    notifyListeners();
  }

  /// REJECT ORDER
  void rejectOrder(int index) {
    _orders[index] = _orders[index].copyWith(
      status: "Rejected",
    );
    notifyListeners();
  }
}
