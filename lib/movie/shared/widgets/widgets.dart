
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constant/string_keys.dart';
import '../style/colors.dart';

PreferredSize appBarDivider() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(1),
    child: buildDivider(),
  );
}

Widget buildDivider() {
  return const Divider(
    thickness: 1,
    height: 1,
    indent: 0,
  );
}

class AppErrorWidget extends StatelessWidget {
  final bool showBack;
  final String title;
  final Color? backgroundColor;

  const AppErrorWidget({
    Key? key,
    this.showBack = false,
    this.title = StringsKeys.somethingWentWrong,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Icon(
                  Icons.movie_filter_outlined,
                  color: AppColors.pinkAccent,
                  size: 180,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    title.tr(),
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 16.0,
            right: 16.0,
            child: Offstage(
              offstage: !showBack,
              child: SafeArea(
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    size: 32.0,
                  ),
                  onPressed: context.pop,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
