import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summarator/common/utils/screen_config.dart';
import 'package:summarator/presentation/screen/summarator/bloc/summarize_bloc.dart';
import 'package:summarator/presentation/theme/color_theme.dart';
import 'package:summarator/presentation/theme/text_styles.dart';

import '../summarator_string.dart';

class InputCard extends StatelessWidget {
  final TextEditingController inputController;
  final FocusNode? focusNode;

  const InputCard({Key? key, required this.inputController, this.focusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: hdp(10), vertical: hdp(10)),
        decoration: BoxDecoration(color: White.justWhite),
        constraints: BoxConstraints(minHeight: hdp(100)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (inputController.text.isNotEmpty)
              Container(
                height: hdp(30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      SummaratorString.originalText,
                      style: TextStyles.ttCommons.copyWith(
                        fontSize: 13,
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        inputController.clear();
                        BlocProvider.of<SummarizeBloc>(context).add(
                          DismissSummary(),
                        );
                      },
                    )
                  ],
                ),
              ),
            TextFormField(
              toolbarOptions: ToolbarOptions(
                copy: true,
                cut: true,
                paste: true,
                selectAll: true,
              ),
              enableInteractiveSelection: true,
              controller: inputController,
              focusNode: focusNode,
              style: TextStyles.ttCommons.copyWith(fontSize: 18),
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: SummaratorString.hintText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
