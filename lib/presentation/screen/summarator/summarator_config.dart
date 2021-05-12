import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summarator/common/injections/injector.dart';
import 'package:summarator/presentation/screen/favorite_screen/favorite_screen.dart';
import 'package:summarator/presentation/screen/summarator/bloc/history_bloc.dart';
import 'package:summarator/presentation/screen/summarator/summarator_string.dart';
import 'package:summarator/presentation/screen/summarator/widgets/drawer_item.dart';

import 'bloc/activity_bloc.dart';
import 'bloc/summarize_bloc.dart';

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
        onTap: () => Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => getIt<HistoryBloc>(),
                ),
                BlocProvider(
                  create: (context) => getIt<ActivityBloc>(),
                ),
                BlocProvider(
                  create: (context) => getIt<SummarizeBloc>(),
                ),
              ],
              child: FavoriteScreen(),
            ),
          ),
        ),
        text: SummaratorString.favorite,
      ),
    ];
