import 'package:flutter/material.dart';

const defaultPadding = 20.0;
const cartBarHeight = 100.0;
const headerHeight = 85.0;

const bgColor = Color(0xFFF6F5F2);
const primaryColor = Color(0xFF40A944);

Color getCategoryColor(String category) {
  switch (category) {
    case 'Crypto':
      return primaryColor;
    case 'Stocks':
      return Colors.pinkAccent;
    case 'Investment':
      return Colors.blue[400]!;
    case 'Savings':
      return Colors.purple[400]!;
    case 'Bank':
      return Colors.blueGrey;
    case 'Miscellaneous':
      return Colors.teal;
    default:
      return Colors.orange[400]!;
  }
}
