import '../../shared/constant/app_value.dart';
import '../../shared/utils/utils.dart';


class MoviesQueryRequest {
  String? apiKey;
  String? language;
  int? page;
  String? query;

  MoviesQueryRequest({
    this.apiKey,
    this.language,
    this.page,
    this.query,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic> {};
    data['api_key'] = apiKey ?? AppValues.apiKey;
    data['language'] = language ?? getLangCode();
    data['page'] = page ?? 1;
    data['query'] = query ?? '';
    return data;
  }
}
