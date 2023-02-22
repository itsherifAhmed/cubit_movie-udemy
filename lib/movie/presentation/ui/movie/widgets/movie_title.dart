
import 'package:flutter/material.dart';

import '../../../../shared/widgets/rating.dart';

Widget buildMovieTitle({
  required BuildContext context,
  required String? title,
  required double? voteAverage,
}) {
  return Padding(
    padding: const EdgeInsets.only(
      top: 8,
      bottom: 22,
      left: 10,
      right: 6,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title ?? '',
          style: Theme.of(context).textTheme.headline2,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: buildRating(
            context: context,
            votes: voteAverage ?? 0,
          ),
        ),
      ],
    ),
  );
}
