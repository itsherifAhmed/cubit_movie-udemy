import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class FilterTitleItem extends StatelessWidget {
  final String title;

  const FilterTitleItem({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 6,
        bottom: 10,
      ),
      child: Text(
        title.tr(),
        style: Theme.of(context).textTheme.headline2,
      ),
    );
  }
}
