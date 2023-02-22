import '../../../../shared/constant/app_value.dart';
import '../../../../shared/constant/string_keys.dart';
import '../../../../shared/widgets/app_network_image.dart';
import '../../../../shared/widgets/app_progress.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../../di/di.dart';
import '../../../router/arguments.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../movie_cubit.dart';
import '../widgets/movie_overview.dart';
import '../widgets/movie_title.dart';

class MovieDesktop extends StatelessWidget {
  final MovieArguments arguments;

  MovieDesktop({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final MovieCubit _movieCubit = getIt.get<MovieCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(StringsKeys.movie.tr()),
        bottom: appBarDivider(),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 1200,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: arguments.movieId.toString() + arguments.posterPath.toString() + AppValues.heroPoster,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 38,
                      ),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 640,
                          maxWidth: 480,
                        ),
                        child: AppNetworkImage(
                          url: AppValues.imageUrl + (arguments.posterPath ?? ''),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 30,
                        left: 24,
                        right: 16,
                        bottom: 16,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildMovieTitle(
                            context: context,
                            title: arguments.title,
                            voteAverage: arguments.voteAverage,
                          ),
                          BlocBuilder<MovieCubit, MovieState>(
                            bloc: _movieCubit..getMovie(arguments.movieId),
                            builder: (BuildContext context, MovieState state) {
                              if (state is MovieLoadingState) {
                                return const Padding(
                                  padding: EdgeInsets.only(top: 36),
                                  child: AppProgress(),
                                );
                              } else if (state is MovieErrorState) {
                                return const AppErrorWidget();
                              } else if (state is MovieLoadedState) {
                                return Flexible(
                                  child: buildMovieOverview(
                                    context: context,
                                    overview: state.movieResponse!.overview,
                                  ),
                                );
                              } else {
                                return const Offstage();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}