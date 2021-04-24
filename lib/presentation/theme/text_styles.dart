import 'package:flutter/material.dart';
import 'package:summarator/common/constants/font_family_constants.dart';

class TextStyles {
  static final basicPoppins = TextStyle(fontFamily: FontFamilyConstants.poppins);
  static final basicTTCommons = TextStyle(fontFamily: FontFamilyConstants.ttCommons);

  static final poppins35 = basicPoppins.copyWith(fontSize: 35);

  static final ttCommons = basicTTCommons.copyWith(fontSize: 16);
}
