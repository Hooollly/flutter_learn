import 'package:flutter/material.dart';
import 'package:flutter_learn/commons/values.dart';

Color asColor(int i) {
  return vCardColors[i % vCardColors.length]!;
}
