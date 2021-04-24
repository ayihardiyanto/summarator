import 'package:flutter/material.dart';

class CommonDialog {
  final Widget content;

  CommonDialog( {required this.content});
  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          Text('Continue'),
          Text('Cancel'),
        ],
        content: content,
      ),
    );
  }
}
