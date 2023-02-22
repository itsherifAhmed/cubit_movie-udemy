import '../../shared/constant/app_value.dart';
import '../../shared/utils/utils.dart';


class MoviesRequest {
  String? apiKey;
  String? language;
  int? page;
  String? sortBy;

  MoviesRequest({
    this.apiKey,
    this.language,
    this.page,
    this.sortBy,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic> {};
    data['api_key'] = apiKey ?? AppValues.apiKey;
    data['language'] = language ?? getLangCode();
    data['page'] = page ?? 1;
    data['sort_by'] = sortBy ?? 'popularity.desc';
    return data;
  }
}
