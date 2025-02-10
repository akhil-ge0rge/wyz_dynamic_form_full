import 'package:flutter/material.dart';

//Helps to Converts a HEX color string into a [Color]
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static Color fromHex(String hexString) {
    return HexColor(hexString);
  }
}
