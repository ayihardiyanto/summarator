import 'package:flutter/material.dart';
import 'package:summarator/common/utils/screen_config.dart';
import 'package:summarator/domain/entities/summary_entity.dart';
import 'package:summarator/presentation/screen/summarator/summarator_string.dart';
import 'package:summarator/presentation/screen/summarator/widgets/list_item.dart';
import 'package:summarator/presentation/theme/color_theme.dart';
import 'package:summarator/presentation/theme/text_styles.dart';

class HistoryList extends StatelessWidget {
  final List<Summary> summaryHistories;
  final bool favorite;

  const HistoryList({Key? key, this.summaryHistories = const [], this.favorite = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (summaryHistories.isEmpty && favorite) {
      return Container(
        width: mqWidth(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              SummaratorString.oops,
              style: TextStyles.poppins35.copyWith(color: Grey.brownGrey),
            ),
            Text(
              SummaratorString.emptyScreen,
              style: TextStyles.ttCommons.copyWith(color: Grey.brownGrey),
            )
          ],
        ),
      );
    }
    return Container(
      color: Colors.white,
      margin: EdgeInsets.all(hdp(5)),
      child: ListView.separated(
        primary: false,
        separatorBuilder: (context, index) => Divider(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: summaryHistories.length,
        itemBuilder: (context, index) =>
            ListItem(summary: summaryHistories[index]),
      ),
    );
  }
}
