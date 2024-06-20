import 'package:flutter/material.dart';

class Arab with ChangeNotifier {
  String? _month;
  String? get month => _month;

  void setMonth(String m) {
    _month = m;
    notifyListeners();
  }
}
