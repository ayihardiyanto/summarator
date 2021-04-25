import 'package:flutter/material.dart';
import 'package:summarator/common/constants/font_family_constants.dart';

import 'color_theme.dart';

class TextStyles {
  static final TextStyle titleBar = TextStyle(
    color: White.justWhite,
    fontFamily: FontFamilyConstants.ttCommons,
    fontSize: 16,
  );

  static final basicPoppins = TextStyle(fontFamily: FontFamilyConstants.poppins);
  static final basicTTCommons = TextStyle(fontFamily: FontFamilyConstants.ttCommons);

  static final poppins35 = basicPoppins.copyWith(fontSize: 35);

  static final ttCommons = basicTTCommons.copyWith(fontSize: 16);
}
