
import 'dart:developer';

import 'package:cubit_movies/movie/domain/response/genre_response.dart';
import 'package:cubit_movies/movie/shared/constant/app_value.dart';
import 'package:cubit_movies/movie/shared/core/network/dio_manager.dart';
import 'package:cubit_movies/movie/shared/utils/utils.dart';

import '../../data/data_sources/remote/repositories/filter_repo.dart';

class FilterRepositoryImpl extends FilterRepository {
  final DioManager _dio;
  FilterRepositoryImpl(this._dio);

  @override
  Future<List<GenreResponse>> getGenres() async {
    List<GenreResponse> res = <GenreResponse>[];
    try {
      return await _dio.get(
        'genre/movie/list',
        parameters: {
          'api_key': AppValues.apiKey,
          'language': getLangCode(),
        },
      ).then((response) {
        res = (response.data['genres'] as List).map((e) {
          return GenreResponse.fromJson(e);
        }).toList();
        return res;
      });
    } catch (e) {
      log(e.toString());
      return res;
    }
  }
}
