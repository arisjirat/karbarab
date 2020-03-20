import 'package:flutter/material.dart';
double deviceHeight(context) {
  final double padding = MediaQuery.of(context).padding.top +
        MediaQuery.of(context).padding.bottom;
    final double _deviceHeight = MediaQuery.of(context).size.height - padding;
  return _deviceHeight;
}