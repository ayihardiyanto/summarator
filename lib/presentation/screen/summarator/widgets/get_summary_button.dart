import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summarator/common/utils/screen_config.dart';
import 'package:summarator/presentation/screen/summarator/bloc/activity_bloc.dart';
import 'package:summarator/presentation/widgets/custom_flat_button.dart';

import '../summarator_string.dart';

class GetSummaryButton extends StatelessWidget {
  final bool visible;
  final Animation<Offset> animateButton;
  final GestureTapCallback? onPressed;

  const GetSummaryButton(
      {Key? key,
      this.visible = false,
      required this.animateButton,
      this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivityBloc, ActivityState>(
      builder: (context, state) {
        if (state is Paused ||
            state is FavoriteResultBoxUpdated ||
            state is UpdatingFavorite) {
          return Container();
        }
        if (state is TextFilled) {
          return SlideTransition(
            position: animateButton,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: hdp(20)),
                padding: EdgeInsets.symmetric(horizontal: wdp(15)),
                child: CustomFlatButton(
                  buttonTitle: SummaratorString.getSummary,
                  onPressed: onPressed,
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
