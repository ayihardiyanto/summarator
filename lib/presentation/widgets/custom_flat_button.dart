import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:summarator/common/utils/screen_config.dart';
import 'package:summarator/presentation/theme/color_theme.dart';

class CustomFlatButton extends StatelessWidget {
  final GestureTapCallback? onPressed;
  final String? buttonTitle;
  final Color? titleColor;
  final Color? buttonColor;
  final ButtonView? buttonStyle;
  final double? height;
  final double? width;
  final bool? enabled;
  final Widget? leadingIcon;

  CustomFlatButton({
    Key? key,
    this.onPressed,
    this.buttonTitle,
    this.titleColor,
    this.buttonColor,
    this.buttonStyle,
    this.height,
    this.width,
    this.enabled,
    this.leadingIcon,
  }) : super(key: key);

  List<Color> buttonStyleBuilder(BuildContext context) {
    final buttonColor = Theme.of(context).buttonColor;
    Color defaultBaseColor;
    Color defaultTitleColor;

    switch (buttonStyle) {
      case ButtonView.DEFAULT:
        defaultBaseColor = buttonColor;
        defaultTitleColor = Colors.white;
        return [defaultBaseColor, defaultTitleColor];
      case ButtonView.STYLE_TWO:
        defaultBaseColor = Colors.grey;
        defaultTitleColor = buttonColor;
        return [defaultBaseColor, defaultTitleColor];
      case ButtonView.TEXT_BUTTON:
        defaultBaseColor = Colors.white;
        defaultTitleColor = Theme.of(context).primaryColor;
        return [defaultBaseColor, defaultTitleColor];
      case ButtonView.OUTLINED:
        defaultBaseColor = Colors.white;
        defaultTitleColor = Theme.of(context).accentColor;
        return [defaultBaseColor, defaultTitleColor];
      case ButtonView.TRANSPARENT:
        defaultBaseColor = Colors.transparent;
        defaultTitleColor = buttonColor;
        return [defaultBaseColor, defaultTitleColor];
      default:
        defaultBaseColor = buttonColor;
        defaultTitleColor = Colors.white;
        return [defaultBaseColor, defaultTitleColor];
    }
  }

  @override
  Widget build(BuildContext context) {
    Color defaultBaseColor = buttonStyleBuilder(context)[0];
    Color defaultTitleColor = buttonStyleBuilder(context)[1];

    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: buttonColor ?? defaultBaseColor,
        primary: defaultTitleColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: buttonStyle == ButtonView.TEXT_BUTTON ||
                  buttonStyle == ButtonView.OUTLINED
              ? BorderSide(color: defaultTitleColor)
              : BorderSide(
                  color: Colors.transparent,
                ),
        ),
      ),
      onPressed: onPressed,
      // textColor: titleColor ?? defaultTitleColor,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leadingIcon != null)
              Row(
                children: [
                  leadingIcon!,
                  SizedBox(
                    width: wdp(10),
                  )
                ],
              ),
            Text(
              buttonTitle ?? 'Button Title',
            ),
          ],
        ),
      ),
    );
  }
}

///[ButtonView] provide you with some default styling you use most
enum ButtonView {
  ///[DEFAULT] is the standard button with primaryColor as base color
  ///and [White.justWhite] as title color
  DEFAULT,

  ///[STYLE_TWO] is the standard button with [Grey.brightGrey] as base color
  ///and primaryColor as title color
  STYLE_TWO,

  ///[TEXT_BUTTON]is the standard button with [White.justWhite] as base color
  ///and primaryColor as title color
  TEXT_BUTTON,

  ///[OUTLINED]is the standard button with [White.justWhite] as base color
  ///and primaryColor as title color and accent color for border line
  OUTLINED,

  ///[TRANSPARENT] if you intend to use only the title, and dont mind with the base color
  TRANSPARENT,
}
