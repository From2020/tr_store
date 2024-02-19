import 'package:flutter/material.dart';

class ItemIdNotifier with ChangeNotifier {
  late int _id;

  int get id => _id;

  set setId(int id) {
    _id = id;
    notifyListeners();
  }
}
