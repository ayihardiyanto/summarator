import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:summarator/common/constants/shared_preferences_constants.dart';
import 'package:summarator/common/injections/injector.dart';
import 'package:summarator/common/utils/local_storage.dart';
import 'package:summarator/common/utils/screen_config.dart';
import 'package:summarator/data/model/package_information_model.dart';
import 'package:summarator/domain/entities/package_information.dart';
import 'package:summarator/presentation/screen/summarator/bloc/activity_bloc.dart';
import 'package:summarator/presentation/screen/summarator/bloc/history_bloc.dart';
import 'package:summarator/presentation/screen/summarator/bloc/summarize_bloc.dart';
import 'package:summarator/presentation/screen/summarator/summarator_string.dart';
import 'package:summarator/presentation/screen/summarator/widgets/app_drawer.dart';
import 'package:summarator/presentation/screen/summarator/widgets/get_summary_button.dart';
import 'package:summarator/presentation/screen/summarator/widgets/history_list.dart';
import 'package:summarator/presentation/screen/summarator/widgets/input_card.dart';
import 'package:summarator/presentation/screen/summarator/widgets/result_box.dart';
import 'package:summarator/presentation/theme/color_theme.dart';
import 'package:summarator/presentation/theme/text_styles.dart';

class SummaratorScreen extends StatefulWidget {
  @override
  _SummaratorScreenState createState() => _SummaratorScreenState();
}

class _SummaratorScreenState extends State<SummaratorScreen>
    with TickerProviderStateMixin {
  late GlobalKey<ScaffoldState> _scaffoldKey;
  late TextEditingController _inputController;
  late FocusNode _inputFocus;
  late SummarizeBloc _summarizeBloc;
  late ActivityBloc _activityBloc;
  late AnimationController _animationController;
  late Animation<Offset> _floatInButtonAnimation;
  late AutoScrollController _scrollController;
  late HistoryBloc _historyBloc;
  late LocalStorage _localStorage;
  late PackageInformation _packageInformation;
  ScrollDirection? _scrollDirection;
  // bool summarized = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _activityBloc = BlocProvider.of<ActivityBloc>(context);
    _summarizeBloc = BlocProvider.of<SummarizeBloc>(context);
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _floatInButtonAnimation =
        Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 0.2))
            .animate(_animationController);
    _activityBloc.addSubscription(_summarizeBloc);
    _historyBloc = BlocProvider.of<HistoryBloc>(context);
    _inputFocus = FocusNode();
    _inputController = TextEditingController();
    _inputController.addListener(() {
      _activityBloc.add(AttachListener(text: _inputController.text));
    });
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _scrollController = AutoScrollController(initialScrollOffset: 500);
    _historyBloc.add(GetHistory());
    _localStorage = getIt<LocalStorage>();
    final decodedAppInfo =
        jsonDecode(_localStorage.getString(SharedPreferencesKey.packageInfo)!);
    _packageInformation = PackageInformationModel.fromJson(
      json: decodedAppInfo,
    );
  }

  void autoScroll() async {
    await _scrollController.scrollToIndex(1);
    await _scrollController.highlight(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Grey.lightGrey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          color: White.justWhite,
        ),
        // centerTitle: true,
        title: Text(
          SummaratorString.appBarTitle,
          style: TextStyles.titleBar,
        ),
        elevation: 0,
      ),
      drawer: AppDrawer(appInfo: _packageInformation,),
      body: Stack(
        children: [
          Container(
            height: mqHeight(context),
            width: mqWidth(context),
            // padding: EdgeInsets.only(bottom: hdp(90)),
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollUpdateNotification) {
                  if (_scrollDirection !=
                      _scrollController.position.userScrollDirection) {
                    _scrollDirection =
                        _scrollController.position.userScrollDirection;
                    if (_scrollController.position.userScrollDirection ==
                        ScrollDirection.forward) {
                      _animationController.reverse();
                    }
                    if (_scrollController.position.userScrollDirection ==
                        ScrollDirection.reverse) {
                      _animationController.forward();
                    }
                    if (_scrollController.position.userScrollDirection ==
                            ScrollDirection.idle &&
                        _inputController.text.isNotEmpty) {
                      _animationController.reverse();
                    }
                  }
                }
                return true;
              },
              child: Align(
                alignment: Alignment.topCenter,
                child: ListView(
                  reverse: true,
                  shrinkWrap: true,
                  controller: _scrollController,
                  physics: BouncingScrollPhysics(),
                  children: [
                    Container(
                      child: Column(
                        children: [
                          InputCard(
                            inputController: _inputController,
                            focusNode: _inputFocus,
                          ),
                          // if (summarized)
                          BlocBuilder<SummarizeBloc, SummarizeState>(
                            builder: (context, state) {
                              if (state is Summarized) {
                                _scrollController.animateTo(0.0,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.bounceIn);
                                return ResultBox(result: state.result!);
                              }
                              return Container();
                            },
                          ),

                          BlocBuilder<ActivityBloc, ActivityState>(
                              builder: (context, state) {
                            if (state is Listened) {
                              if (state.text.isEmpty) {
                                return BlocBuilder<HistoryBloc, HistoryState>(
                                  builder: (context, state) {
                                    if (state is HistoryLoaded) {
                                      return HistoryList(
                                        summaryHistories: state.summaries,
                                      );
                                    }
                                    return HistoryList();
                                  },
                                );
                              }
                              return Container();
                            }
                            if (state is Paused) {
                              return Container();
                            }
                            return BlocBuilder<HistoryBloc, HistoryState>(
                              builder: (context, state) {
                                if (state is HistoryLoaded) {
                                  return HistoryList(
                                    summaryHistories: state.summaries,
                                  );
                                }
                                return HistoryList();
                              },
                            );
                          }),
                          SizedBox(
                            height: hdp(80),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          GetSummaryButton(
            visible: _inputController.text.isNotEmpty,
            animateButton: _floatInButtonAnimation,
            onPressed: () {
              _summarizeBloc.add(
                GetSummarization(text: _inputController.text),
              );
              _inputFocus.unfocus();
            },
          )
        ],
      ),
    );
  }
}
