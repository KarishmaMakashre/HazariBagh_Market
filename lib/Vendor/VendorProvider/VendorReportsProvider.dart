import 'package:flutter/material.dart';
import '../models/report_model.dart';

class VendorReportsProvider extends ChangeNotifier {
  /// 🔹 SUMMARY CARDS DATA
  final List<ReportModel> _summaryCards = [
    ReportModel(
      title: "Total Orders",
      value: "1,245",
      icon: Icons.shopping_bag,
      colorCode: 0xFF2563EB,
    ),
    ReportModel(
      title: "Total Revenue",
      value: "₹2.45L",
      icon: Icons.currency_rupee,
      colorCode: 0xFF16A34A,
    ),
    ReportModel(
      title: "Active Products",
      value: "132",
      icon: Icons.inventory_2,
      colorCode: 0xFFF59E0B,
    ),
    ReportModel(
      title: "Customers",
      value: "845",
      icon: Icons.people,
      colorCode: 0xFFDC2626,
    ),
  ];

  /// 🔹 SALES SUMMARY
  final Map<String, String> _salesSummary = {
    "Today Sales": "₹12,450",
    "This Week": "₹85,200",
    "This Month": "₹2,45,000",
    "Total Sales": "₹12,30,000",
  };

  /// GETTERS
  List<ReportModel> get summaryCards => _summaryCards;
  Map<String, String> get salesSummary => _salesSummary;

  /// 🔄 OPTIONAL: UPDATE DATA (future API use)
  void updateReports({
    List<ReportModel>? cards,
    Map<String, String>? summary,
  }) {
    if (cards != null) {
      _summaryCards
        ..clear()
        ..addAll(cards);
    }
    if (summary != null) {
      _salesSummary
        ..clear()
        ..addAll(summary);
    }
    notifyListeners();
  }
}
