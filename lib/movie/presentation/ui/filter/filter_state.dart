part of 'filter_cubit.dart';

@immutable
abstract class FilterState {}

class FilterInitial extends FilterState {}

class FilterError extends FilterState {}

class FilterLoading extends FilterState {}

class FilterLoaded extends FilterState {
  String year;
  List<GenreResponse> genres;
  List<GenreResponse> selectedGenres;

  FilterLoaded(
      {required this.year, required this.genres, required this.selectedGenres});
}
