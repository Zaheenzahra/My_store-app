import 'package:flutter/material.dart';
import 'package:my_store/modals/prroduct_models.dart';

class FavouriteProvider with ChangeNotifier {
  final List<Products> _selectedItems = [];

  List<Products> get selectedItems => _selectedItems;

  bool isFavorite(Products product) {
    return _selectedItems.contains(product);
  }

  void addItem(Products product) {
    _selectedItems.add(product);
    notifyListeners();
  }

  void removeItem(Products product) {
    _selectedItems.remove(product);
    notifyListeners();
  }
}
