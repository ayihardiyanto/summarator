import 'package:flutter/material.dart';
import 'package:summarator/common/utils/screen_config.dart';
import 'package:summarator/domain/entities/summary_entity.dart';
import 'package:summarator/presentation/theme/color_theme.dart';
import 'package:summarator/presentation/theme/text_styles.dart';

class HistoryList extends StatelessWidget {
  final List<Summary> summaryHistories;

  const HistoryList({Key? key, this.summaryHistories = const []})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.all(hdp(5)),
      child: ListView.separated(
        primary: false,
        separatorBuilder: (context, index) => Divider(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: summaryHistories.length,
        itemBuilder: (context, index) => Container(
          width: mqWidth(context),
          padding: EdgeInsets.all(hdp(10)),
          height: hdp(60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      summaryHistories[index].originalText!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyles.ttCommons,
                    ),
                    Text(
                      summaryHistories[index].summarizedText!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyles.ttCommons.copyWith(fontSize: 14),
                    )
                  ],
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.star_border,
                  color: Grey.darkGrey,
                ),
                onPressed: () {
                  // final bloc = BlocProvider.of<ActivityBloc>(context);
                  // if (state is FavoriteUpdated && state.favorite) {
                  //   bloc.add(RemoveFavorite(summary: result));
                  // }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
