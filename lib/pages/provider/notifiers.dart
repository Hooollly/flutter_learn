import 'package:flutter/material.dart';

class Tick extends ChangeNotifier {
  int i = 0;

  int i_2 = 0;

  int i_4 = 0;

  increment() {
    /// i 每次自增1
    i++;

    /// a 每2次自增1
    if (i % 2 == 0) i_2++;

    /// b 每4次自增1
    if (i % 4 == 0) i_4++;

    notifyListeners();
  }

  @override
  String toString() {
    return '{i: $i, a: $i_2, b: $i_4}';
  }
}
