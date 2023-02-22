import '../response/genre_response.dart';
class FilterModel {
  String year;
  List<GenreResponse> selectedGenres;

  FilterModel({
    required this.year,
    required this.selectedGenres,
  });
}
