import 'package:flutter/material.dart';

class Tick extends ChangeNotifier {
  int i = 0;

  int a = 0;

  int b = 0;

  increment() {
    /// i 每次自增1
    i++;

    // a 每2次自增1
    if (i % 2 == 0) a++;

    /// b 每3次自增1
    if (i % 3 == 0) b++;

    notifyListeners();
  }

  @override
  String toString() {
    return '{i: $i, a: $a, b: $b}';
  }
}
