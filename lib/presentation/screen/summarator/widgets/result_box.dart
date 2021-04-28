import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summarator/common/utils/screen_config.dart';
import 'package:summarator/domain/entities/summary_entity.dart';
import 'package:summarator/presentation/screen/summarator/bloc/activity_bloc.dart';
import 'package:summarator/presentation/screen/summarator/summarator_string.dart';
import 'package:summarator/presentation/theme/color_theme.dart';
import 'package:summarator/presentation/theme/text_styles.dart';

class ResultBox extends StatefulWidget {
  final Summary result;

  const ResultBox({Key? key, required this.result}) : super(key: key);

  @override
  _ResultBoxState createState() => _ResultBoxState();
}

class _ResultBoxState extends State<ResultBox> {
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
                BlocBuilder<ActivityBloc, ActivityState>(
                  builder: (context, state) => IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      state is FavoriteResultBoxUpdated && state.favorite
                          ? Icons.star
                          : Icons.star_border,
                      color: White.justWhite,
                    ),
                    onPressed: () {
                      final bloc = BlocProvider.of<ActivityBloc>(context);
                      if (state is FavoriteResultBoxUpdated && state.favorite) {
                        bloc.add(ResultBoxRemoveFavorite(summary: widget.result));
                      }else{
                        bloc.add(ResultBoxAddToFavorite(summary: widget.result));}
                    },
                  ),
                )
              ],
            ),
          ),
          Text(
            widget.result.summarizedText!,
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
