
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../shared/constant/string_keys.dart';

Widget buildMovieOverview({
  required BuildContext context,
  required String? overview,
}) {
  return Offstage(
    offstage: (overview ?? '').isEmpty,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 18.0, left: 10.0, right: 10.0),
          child: Text(
            StringsKeys.description.tr(),
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0, bottom: 20.0, left: 10.0, right: 10.0),
          child: Text(
            overview ?? '',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ],
    ),
  );
}
