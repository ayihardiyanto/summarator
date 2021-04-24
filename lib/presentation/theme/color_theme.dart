import 'package:flutter/material.dart';

class Blue {
  static const softBlue = Color(0xff59b2e2);
  static const teal = Color(0xff00BCD4);
}

class White {
  static const justWhite = Color(0xffffffff);
}

class Red {
  static const pinkyBlush = Color(0xffFF4081);
}

class Grey {
  static final Color gray = Color(0xff333333);
  static final Color ashGrey = Color(0xff898a8d);
  static final Color brownGrey = Color(0xff828282);
  static final Color darkGrey = Color(0xff686868);
  static final Color brightGrey = Color(0xffefefef);
  static final Color warmGrey = Color(0xff707070);
  static final Color greyedText = Color(0xffbdbdbd);
  static final Color lightGreyBlue = Color(0xffa4d9cc);
  static final Color silverTwo = Color(0xffb3cdbf);
  static final Color greyish = Color(0xffb9b9b9);
  static final Color grey = Color(0xffe0e0e0);
  static final Color greyishBrown = Color(0xff4b413a);
  static final Color warmGrey2 = Color(0xffc7c4c4);
  static const Color grey2 = Color(0xff686868);
  static final Color grey3 = Color(0xff4f4f4f);
  static final Color grey4 = Color(0xffa3a3a3);
  static final Color grayish = Color(0xfff9f9f9);
  static const Color labelColor = Color(0xff4d4d4d);
  static const Color highlightColor = Color(0xffcccccc);
  static const reddishGrey = Color(0xffE6E6E6);
  static const lightGrey = Color(0xfff1f1f1);
}

class AvatarColor {
  Color? getAvatarColor(String letter) {
    switch (letter.toLowerCase()) {
      case 'a':
      case 'o':
        return Colors.amber;
      case 'b':
      case 'p':
        return Colors.blue;
      case 'c':
      case 'q':
        return Colors.cyanAccent;
      case 'd':
      case 'r':
        return Colors.deepOrange;
      case 'e':
      case 's':
        return Colors.red[400];
      case 'f':
      case 't':
        return Colors.blueGrey;
      case 'g':
      case 'u':
        return Colors.green;
      case 'h':
      case 'v':
        return Colors.red;
      case 'i':
      case 'w':
        return Colors.indigo;
      case 'j':
      case 'x':
        return Colors.brown;
      case 'k':
      case 'y':
        return Colors.deepPurple;
      case 'l':
      case 'z':
        return Colors.blueGrey[800];
      case 'm':
        return Colors.indigo[300];
      case 'n':
      default:
        return Colors.green[900];
    }
  }
}
