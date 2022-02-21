import 'package:flutter/material.dart';

class Tick extends ChangeNotifier {
  int i = 0;

  int i_2 = 0;

  int i_4 = 0;

  increment([int value = 1]) {
    i += value;

    ///
    i_2 += i ~/ 2;

    ///
    i_4 += i ~/ 4;

    notifyListeners();
  }

  @override
  String toString() {
    return '{i: $i, a: $i_2, b: $i_4}';
  }
}
