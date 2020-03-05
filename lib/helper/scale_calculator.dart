import 'package:flutter/material.dart';

double scaleCalculator(size, context) {
  final double _deviceHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
  // return (size * _deviceHeight) / 896.0;
  return size + 0.0;
}