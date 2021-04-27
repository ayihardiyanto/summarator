import 'dart:math';
import 'package:flutter/material.dart';

class RotatingDropdownIcon extends StatefulWidget {
  final AnimationController? animationController;
  final Widget? icon;
  final Function? function;
  RotatingDropdownIcon({
    Key? key,
    this.animationController,
    this.icon,
    this.function,
  }) : super(key: key);
  @override
  _RotatingDropdownIconState createState() => _RotatingDropdownIconState();
}

class _RotatingDropdownIconState extends State<RotatingDropdownIcon>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  Duration animationDuration = Duration(milliseconds: 300);
  @override
  void initState() {
    super.initState();
    animationController = widget.animationController ??
        AnimationController(vsync : this, duration: animationDuration);
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context);
    return Container(
      child: AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext? context, Widget? _widget) {
          return Transform.rotate(
            angle:
                Tween(begin: 0.0, end: pi).animate(animationController).value,
            child: _widget,
          );
        },
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            if (widget.animationController == null) {
              widget.function!();
              setState(() {
                animationController.isCompleted
                    ? animationController.reverse()
                    : animationController.forward();
              });
            }
          },
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Transform.rotate(
                angle: -1.55,
                              child: widget.icon ??
                    Icon(
                      Icons.arrow_back_ios,
                      color: color.accentColor,
                      size: 20,
                    ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
