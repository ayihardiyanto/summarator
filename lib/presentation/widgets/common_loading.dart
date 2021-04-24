import 'package:flutter/material.dart';
import 'package:summarator/common/utils/screen_config.dart';

class CommonLoading extends StatefulWidget {
  @override
  _CommonLoadingState createState() => _CommonLoadingState();
}

class _CommonLoadingState extends State<CommonLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animationController.repeat();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: mqHeight(context),
      width: mqWidth(context),
      color: Colors.black.withOpacity(0.2),
      child: Center(
        child: CircularProgressIndicator(
          valueColor: _animationController.drive(
            ColorTween(
              begin: Theme.of(context).primaryColor,
              end: Theme.of(context).accentColor,
            ),
          ),
        ),
      ),
    );
  }
}
