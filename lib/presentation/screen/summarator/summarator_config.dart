import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summarator/presentation/screen/summarator/bloc/history_bloc.dart';
import 'package:summarator/presentation/screen/summarator/summarator_string.dart';
import 'package:summarator/presentation/screen/summarator/widgets/drawer_item.dart';

List<DrawerItemProps> getDrawerProps(BuildContext context) => [
  DrawerItemProps(
    icon: Icons.delete,
    onTap: () {
      BlocProvider.of<HistoryBloc>(context).add(ClearHistory());
      Navigator.pop(context);
    },
    text: SummaratorString.clearHistory,
  ),
  DrawerItemProps(
    icon: Icons.star,
    // onTap: () => getIt<HistoryBloc>().add(ClearHistory()),
    text: SummaratorString.favorite,
  ),
];
