part of 'movie_cubit.dart';

@immutable
abstract class MovieState {}

class MovieInitialState extends MovieState {}
class MovieErrorState extends MovieState {}
class MovieLoadingState extends MovieState {}
class MoviePaginationState extends MovieState {}
class MovieLoadedState extends MovieState {
  MovieResponse? movieResponse;

  MovieLoadedState({
    required this.movieResponse
});
}
