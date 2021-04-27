import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:summarator/common/utils/logger.dart';
import 'package:summarator/common/utils/screen_config.dart';
import 'package:summarator/presentation/screen/summarator/bloc/activity_bloc.dart';
import 'package:summarator/presentation/screen/summarator/bloc/summarize_bloc.dart';
import 'package:summarator/presentation/screen/summarator/summarator_string.dart';
import 'package:summarator/presentation/screen/summarator/widgets/input_card.dart';
import 'package:summarator/presentation/screen/summarator/widgets/result_box.dart';
import 'package:summarator/presentation/theme/color_theme.dart';
import 'package:summarator/presentation/theme/text_styles.dart';
import 'package:summarator/presentation/widgets/custom_flat_button.dart';

class SummaratorScreen extends StatefulWidget {
  @override
  _SummaratorScreenState createState() => _SummaratorScreenState();
}

class _SummaratorScreenState extends State<SummaratorScreen> {
  late TextEditingController inputController;
  late FocusNode inputFocus;
  late SummarizeBloc summarizeBloc;
  late ActivityBloc activityBloc;
  late ScrollController scrollController;
  bool forward = true;
  // bool summarized = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    activityBloc = BlocProvider.of<ActivityBloc>(context);
    summarizeBloc = BlocProvider.of<SummarizeBloc>(context);
    activityBloc.addSubscription(summarizeBloc);
    inputFocus = FocusNode();
    inputController = TextEditingController();
    inputController.addListener(() {
      activityBloc.add(AttachListener());
    });
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
          forward = false;
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
          forward = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Grey.lightGrey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
          color: White.justWhite,
        ),
        // centerTitle: true,
        title: Text(
          SummaratorString.appBarTitle,
          style: TextStyles.titleBar,
        ),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            height: mqHeight(context),
            width: mqWidth(context),
            // padding: EdgeInsets.only(bottom: hdp(90)),
            child: SingleChildScrollView(
              controller: scrollController,
              physics: BouncingScrollPhysics(),
              child: Container(
                child: Column(
                  children: [
                    InputCard(
                      inputController: inputController,
                      focusNode: inputFocus,
                    ),
                    // if (summarized)
                    BlocBuilder<SummarizeBloc, SummarizeState>(
                      builder: (context, state) {
                        if (state is Summarized) {
                          return ResultBox(result: state.result!);
                        }
                        return Container();
                      },
                    ),
                    SizedBox(
                      height: hdp(80),
                    )
                  ],
                ),
              ),
            ),
          ),
          BlocBuilder<ActivityBloc, ActivityState>(
            builder: (context, state) {
              if (inputController.text.isNotEmpty &&
                  state is! Paused) {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: hdp(20)),
                    padding: EdgeInsets.symmetric(horizontal: wdp(15)),
                    child: CustomFlatButton(
                      buttonTitle: SummaratorString.getSummary,
                      onPressed: () {
                        // summarized = true;
                        summarizeBloc.add(
                          GetSummarization(text: inputController.text),
                        );
                        inputFocus.unfocus();
                      },
                    ),
                  ),
                );
              }
              return Container();
            },
          )
        ],
      ),
    );
  }
}
