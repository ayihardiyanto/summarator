import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summarator/common/utils/logger.dart';
import 'package:summarator/common/utils/screen_config.dart';
import 'package:summarator/domain/entities/summary_entity.dart';
import 'package:summarator/presentation/screen/summarator/bloc/activity_bloc.dart';
import 'package:summarator/presentation/screen/summarator/bloc/summarize_bloc.dart';
import 'package:summarator/presentation/theme/text_styles.dart';

class ListItem extends StatelessWidget {
  final Summary summary;

  const ListItem({Key? key, required this.summary}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Log.e('TAPPEd');
        BlocProvider.of<SummarizeBloc>(context).add(
          GetSummarizationFromHistory(summary: summary),
        );
      },
      child: Container(
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
                    summary.originalText!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyles.ttCommons,
                  ),
                  Text(
                    summary.summarizedText!,
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
                summary.favorite ? Icons.star : Icons.star_border,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                final activityBloc = BlocProvider.of<ActivityBloc>(context);
                if (summary.favorite) {
                  activityBloc.add(RemoveFavorite(summary: summary));
                } else {
                  activityBloc.add(AddToFavorite(summary: summary));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
