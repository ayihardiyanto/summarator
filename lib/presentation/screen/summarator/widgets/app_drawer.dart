import 'package:flutter/material.dart';
import 'package:summarator/common/utils/screen_config.dart';
import 'package:summarator/domain/entities/package_information.dart';
import 'package:summarator/presentation/screen/summarator/summarator_config.dart';
import 'package:summarator/presentation/screen/summarator/summarator_string.dart';
import 'package:summarator/presentation/screen/summarator/widgets/drawer_item.dart';
import 'package:summarator/presentation/theme/color_theme.dart';
import 'package:summarator/presentation/theme/text_styles.dart';

class AppDrawer extends StatelessWidget {
  final PackageInformation? appInfo;

  const AppDrawer({Key? key, this.appInfo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final drawerProps = getDrawerProps(context);
    return Drawer(
      child: Container(
        margin: EdgeInsets.only(left: wdp(20), top: hdp(50), bottom: hdp(50)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                drawerProps.length,
                (index) => DrawerItem(
                  props: drawerProps[index],
                ),
              ),
            ),
            Text(
              SummaratorString.version + appInfo!.version,
              style: TextStyles.ttCommons.copyWith(color: Grey.darkGrey, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
