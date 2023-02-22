part of 'home_cubit.dart';

@immutable

abstract class HomeState {}

class HomeEmptyState extends HomeState {}

class HomeErrorState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeMoviesLoadingState extends HomeState {}

class HomePaginationState extends HomeState {}

class HomeLoadedState extends HomeState {
  List<MoviesResponse> movies;
  PaginationScrollController moviesSC;
  FilterModel? filterModel;
  bool paginationLoader;

  HomeLoadedState({
    required this.movies,
    required this.moviesSC,
    required this.filterModel,
    required this.paginationLoader,
  });
}
