import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:summarator/common/extentions/size_extention.dart';

class ScreenConfig {
  double hFactor = 8.2;
  double wFactor = 3.75;
  static ScreenConfig? _instance;

  static double _actualHeight = 0;
  static double _actualWidth = 0;
  static double _heightMultiplier = 0;
  static double _widthMultiplier = 0;

  static double _blockWidth = 0;
  static double _blockHeight = 0;

  ScreenConfig._();

  factory ScreenConfig() {
    assert(
      _instance != null,
      '\nEnsure to initialize ScreenUtil before accessing it.\nPlease execute the init method : ScreenUtil.init()',
    );
    return _instance!;
  }

  static void init(BoxConstraints constraints) {
    _instance ??= ScreenConfig._();
    _actualHeight = constraints.maxHeight;
    _actualWidth = constraints.maxWidth;

    _blockWidth = _actualWidth / 100;
    _blockHeight = _actualHeight / 100;

    _heightMultiplier = _blockHeight;
    _widthMultiplier = _blockWidth;
  }

  ///@param [size] is the size of the font on UI design
  ///height and width size is based on density of the screen

  double height(num size) => (size / hFactor) * _heightMultiplier;

  double width(num size) => (size / wFactor) * _widthMultiplier;

  ///@param [size] is the size of the font on UI design
  ///@param [allowFontScalingSelf] is used whenever the text need to be scaled based on density of the screen
  ///You can set @param [allowFontScalingSelf] true if you need to scale text
  ///and set it to false, or leave it blank if you desired to have the text follow the system [textScaleFactor]

  double fontSize(num size, {bool? allowFontScalingSelf}) =>
      allowFontScalingSelf == null || allowFontScalingSelf == false
          ? size.toDouble()
          : height(size);
}

double wdp(double size) => size.w.toDouble();

double hdp(double size) => size.w.toDouble();

double mqHeight(BuildContext context) => MediaQuery.of(context).size.height;

double mqWidth(BuildContext context) => MediaQuery.of(context).size.width;
