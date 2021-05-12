import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summarator/common/constants/common_constants.dart';
import 'package:summarator/common/constants/summary_constants.dart';
import 'package:summarator/common/utils/logger.dart';
import 'package:summarator/common/utils/screen_config.dart';
import 'package:summarator/data/model/summary_model.dart';
import 'package:summarator/domain/entities/summary_entity.dart';
import 'package:summarator/presentation/screen/favorite_screen/favorite_strings.dart';
import 'package:summarator/presentation/screen/summarator/bloc/history_bloc.dart';
import 'package:summarator/presentation/screen/summarator/widgets/history_list.dart';
import 'package:summarator/presentation/theme/text_styles.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late HistoryBloc _historyBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _historyBloc = BlocProvider.of<HistoryBloc>(context);
    _historyBloc.add(GetHistory());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).accentColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          FavoriteStrings.favorites,
          style: TextStyles.titleBar,
        ),
      ),
      body: Container(
        height: mqHeight(context),
        child: BlocBuilder<HistoryBloc, HistoryState>(
          builder: (context, state) {
            List<Summary> summaries = [];
            if (state is HistoryLoaded) {
              final retrievedSummary = state.summaries
                  .where((element) =>
                      element.key!.contains(SummaryConstants.favorite))
                  .toList();
              if (retrievedSummary.isNotEmpty) {
                Summary reduced = retrievedSummary.reduce((value, element) {
                  Log.e(value.runtimeType);
                  final currentKey = value.key!.replaceAll(
                    SummaryConstants.history,
                    CommonConstants.emptyString,
                  );
                  final nextKey = element.key!.replaceAll(
                    SummaryConstants.history,
                    CommonConstants.emptyString,
                  );
                  if (currentKey == nextKey) {
                    return value as SummaryModel;
                  }
                  return element as SummaryModel;
                });
                summaries.add(reduced);
              }
            }
            return HistoryList(
              summaryHistories: summaries,
              favorite: true,
            );
          },
        ),
      ),
    );
  }
}
