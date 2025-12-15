import 'package:flutter/material.dart';
import '../Model/store_model.dart';

class StoreProvider extends ChangeNotifier {
  StoreModel? _selectedStore;

  StoreModel? get selectedStore => _selectedStore;

  void setStore(StoreModel store) {
    _selectedStore = store;
    notifyListeners();
  }
}
