import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:summarator/common/constants/common_constants.dart';
import 'package:summarator/common/utils/screen_config.dart';
import 'package:summarator/presentation/theme/color_theme.dart';
import 'package:summarator/presentation/theme/text_styles.dart';

class DrawerItem extends StatelessWidget {
  final DrawerItemProps? props;

  const DrawerItem({
    Key? key,
    this.props,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: props?.onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: hdp(10)),
        child: Row(
          children: [
            Icon(
              props?.icon ?? Icons.close,
              color: Theme.of(context).accentColor,
              size: hdp(25),
            ),
            SizedBox(
              width: wdp(20),
            ),
            Text(
              props?.text ?? CommonConstants.emptyString,
              style: TextStyles.ttCommons.copyWith(
                  color: Grey.darkGrey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}

class DrawerItemProps extends Equatable {
  final IconData? icon;
  final String? text;
  final GestureTapCallback? onTap;

  DrawerItemProps({this.icon, this.text, this.onTap});
  @override
  // TODO: implement props
  List<Object?> get props => [icon, text, onTap];
}
