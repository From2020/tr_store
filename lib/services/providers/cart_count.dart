import 'package:flutter/foundation.dart';

class CountNotifier with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  set setCount(int count) {
    _count = count;
    notifyListeners();
  }
}
