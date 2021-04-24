import 'package:flutter/material.dart';
import 'package:summarator/common/utils/screen_config.dart';

class ErrorDialogContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        height: hdp(300),
        width: wdp(300),
        child: Text('This is Error'),
      ),
    );
  }
}
