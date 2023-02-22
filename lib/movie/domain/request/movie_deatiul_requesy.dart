import '../../shared/constant/app_value.dart';
import '../../shared/utils/utils.dart';


class MovieRequest {
  String? apiKey;
  String? language;
  int? movieId;

  MovieRequest({
    this.apiKey,
    this.language,
    this.movieId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic> {};
    data['api_key'] = apiKey ?? AppValues.apiKey;
    data['language'] = language ?? getLangCode();
    return data;
  }
}

///https://baseUrl/method/MovieId?api_key=61222fdc8669a6536695abd204a053a8&language=en_Us
///
///
/// dio.get (baseUrl//3/movie/505642?)
