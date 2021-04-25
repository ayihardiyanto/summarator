import 'package:flutter/material.dart';
import 'package:summarator/common/utils/screen_config.dart';
import 'package:summarator/presentation/screen/summarator/summarator_string.dart';
import 'package:summarator/presentation/theme/color_theme.dart';
import 'package:summarator/presentation/theme/text_styles.dart';

class ResultBox extends StatelessWidget {
  final String result;

  const ResultBox({Key? key, required this.result}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(minHeight: hdp(100), minWidth: mqWidth(context)),
      color: Theme.of(context).primaryColor,
      margin: EdgeInsets.all(hdp(5)),
      padding: EdgeInsets.all(hdp(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: hdp(30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  SummaratorString.summarizedText,
                  style: TextStyles.ttCommons
                      .copyWith(fontSize: 13, color: White.justWhite),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.star_border,
                    color: White.justWhite,
                  ),
                  onPressed: () {},
                )
              ],
            ),
          ),
          Text(
            result,
            style: TextStyles.ttCommons.copyWith(
              color: White.justWhite,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
