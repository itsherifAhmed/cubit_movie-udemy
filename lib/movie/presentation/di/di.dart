import 'package:cubit_movies/movie/data/data_sources/local/prefrance.dart';
import 'package:cubit_movies/movie/data/data_sources/remote/repositories/filter_repo.dart';
import 'package:cubit_movies/movie/data/data_sources/remote/repositories/movie_repo.dart';
import 'package:get_it/get_it.dart';

import '../../domain/repositories/filter_repo_impl.dart';
import '../../domain/repositories/movie_rep[o_impl.dart';
import '../../shared/core/network/dio_manager.dart';
import '../ui/filter/filter_cubit.dart';
import '../ui/home/home_cubit.dart';
import '../ui/movie/movie_cubit.dart';
import '../ui/settings/settings_cubit.dart';

final GetIt getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton(() => Preferences());
  getIt.registerLazySingleton(() => DioManager());
  _setupRepositories();
  setupBlocs();
}

void setupBlocs() {
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt.get()));
  getIt.registerFactory<MovieCubit>(() => MovieCubit(getIt.get()));
  getIt.registerFactory<FilterCubit>(() => FilterCubit(getIt.get()));
  getIt.registerFactory<SettingsCubit>(() => SettingsCubit(getIt.get()));

}

void _setupRepositories() {
  getIt.registerSingleton<MoviesRepository>(MoviesRepositoryImpl(getIt.get<DioManager>()));

  getIt.registerSingleton<FilterRepository>(FilterRepositoryImpl(getIt.get()));
}
