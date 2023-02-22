
import 'package:flutter/material.dart';

import '../../router/arguments.dart';
import 'components/movie_desktop.dart';
import 'components/movie_mobile.dart';


class MovieScreen extends StatelessWidget {
  final MovieArguments arguments;

  const MovieScreen({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth <= 800) {
          return MovieMobile(
            arguments: arguments,
          );
        } else {
          return MovieDesktop(
            arguments: arguments,
          );
        }
      },
    );
  }
}