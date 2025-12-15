import 'package:flutter/material.dart';

class JobsServicesProvider extends ChangeNotifier {
  bool isJobsSelected = true;

  String selectedCategory = "All";

  List<Map<String, String>> jobsList = [
    {
      "title": "Flutter Developer",
      "company": "Tech Solutions",
      "salary": "₹4-6 LPA",
      "type": "Full Time",
      "category": "IT & Software",
    },
    {
      "title": "Sales Executive",
      "company": "ABC Pvt Ltd",
      "salary": "₹2-4 LPA",
      "type": "Full Time",
      "category": "Sales & Mark.",
    },
    {
      "title": "Hospital Nurse",
      "company": "City Hospital",
      "salary": "₹3-5 LPA",
      "type": "Shift",
      "category": "Healthcare",
    },
    {
      "title": " Education ",
      "company": "Davv ",
      "salary": "₹4-5 LPA",
      "type": "Shift",
      "category": "Education",
    },
  ];

  List<Map<String, String>> servicesList = [];

  /// ✅ TAB SWITCH
  void selectJobs() {
    isJobsSelected = true;
    notifyListeners();
  }

  void selectServices() {
    isJobsSelected = false;
    notifyListeners();
  }

  /// ✅ CATEGORY FILTER
  void selectCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  /// ✅ FILTERED DATA
  List<Map<String, String>> get filteredList {
    final list = isJobsSelected ? jobsList : servicesList;

    if (selectedCategory == "All") {
      return list;
    }

    return list
        .where((item) => item["category"] == selectedCategory)
        .toList();
  }
}
