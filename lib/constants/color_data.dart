// ignore: file_names
import 'package:flutter/material.dart';

Color primaryColor = "#146C62".toColor();
Color backgroundColor = "#F9F9F9".toColor();
Color fontBlack = "#000000".toColor();
Color greyFont = "#616161".toColor();
Color cardColor = Colors.white;
Color shadowColor = Colors.black12;


extension ColorExtension on String {
  toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}
