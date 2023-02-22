import 'package:cubit_movies/movie/shared/utils/utils.dart';

import '../../shared/constant/app_value.dart';


class FilterRequest {
  String? apiKey;
  String? language;
  String? withGenres;
  String? sortBy;
  int? year;
  int? page;

  FilterRequest({
    this.apiKey,
    this.language,
    this.withGenres,
    this.sortBy,
    this.year,
    this.page,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic> {};
    data['api_key'] = apiKey ?? AppValues.apiKey;
    data['language'] = language ?? getLangCode();
    data['with_genres'] = withGenres ?? '';
    data['sort_by'] = sortBy ?? 'popularity.desc';
    if (year != null) {
      data['year'] = year;
    }
    data['page'] = page ?? 1;
    return data;
  }
}
