
import 'package:flutter/material.dart';

import '../../../../domain/response/movies_response.dart';
import '../../../../shared/constant/app_value.dart';
import '../../../../shared/style/colors.dart';
import '../../../../shared/widgets/app_network_image.dart';
import '../../../../shared/widgets/rating.dart';

class MovieItem extends StatelessWidget {
  final MoviesResponse movie;
  final void Function()? onTap;

  const MovieItem({
    Key? key,
    required this.movie,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 280,
        ),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2 - 28,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: AppColors.black.withOpacity(0.1),
                    child: AspectRatio(
                      aspectRatio: 27 / 40,
                      child: Hero(
                        tag: movie.id.toString() + movie.posterPath.toString() + AppValues.heroPoster,
                        child: AppNetworkImage(
                          url: AppValues.imageUrl + (movie.posterPath ?? ''),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: buildRating(
                      context: context,
                      votes: movie.voteAverage ?? 0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      movie.title ?? '',
                      style: Theme.of(context).textTheme.headline3,
                      overflow: TextOverflow.fade,
                      softWrap: false,
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
