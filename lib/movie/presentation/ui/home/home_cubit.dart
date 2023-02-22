import 'dart:async';
import 'dart:developer';

import 'package:cubit_movies/movie/domain/entities/filter_model.dart';
import 'package:cubit_movies/movie/domain/request/filter_request.dart';
import 'package:cubit_movies/movie/domain/request/movie_query_request.dart';
import 'package:cubit_movies/movie/domain/response/genre_response.dart';
import 'package:cubit_movies/movie/shared/core/base/pageintation_scroll_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data_sources/remote/repositories/movie_repo.dart';
import '../../../domain/request/movies_request.dart';
import '../../../domain/response/movies_response.dart';
import 'home_enum.dart';

part 'home_state.dart';
class HomeCubit extends Cubit<HomeState> {
  final MoviesRepository moviesRepository;

  HomeCubit(this.moviesRepository) : super(HomeEmptyState()) {
    init();
  }

  late PaginationScrollController moviesSC;
  HomeEnums type = HomeEnums.main;
  bool stopPagination = false;
  int page = 1;
  Timer? _searchDebounce;
  String query = '';
  final List<MoviesResponse> movies = [];
  FilterModel? filterModel;
  FilterRequest? filterRequest;


  Future<List<MoviesResponse>> getMovies(MoviesRequest data) async {
    return await moviesRepository.getMovies(data);
  }

  void getAllMovies([type = HomeEnums.main]) async {
    if (type != HomeEnums.main) {
      emit(HomeMoviesLoadingState());
    } else if (page == 1) {
      emit(HomeLoadingState());
    } else {
      emit(
        HomeLoadedState(
          movies: movies,
          moviesSC: moviesSC,
          filterModel: filterModel,
          paginationLoader: true,
        ),
      );

    }
    final List<MoviesResponse> loadedMovies = await getMovies(
      MoviesRequest(page: page),
    );
    stopPagination = loadedMovies.isEmpty;
    movies.addAll(loadedMovies);
    emit(
      HomeLoadedState(
        movies: movies,
        moviesSC: moviesSC,
        filterModel: filterModel,
        paginationLoader: false,
      ),
    );
  }


  void searchMoviesByQuery(String query) async {
    if (page == 1) {
      emit(HomeMoviesLoadingState());
    } else {
      emit(
        HomeLoadedState(
          movies: movies,
          moviesSC: moviesSC,
          filterModel: filterModel,
          paginationLoader: true,
        ),
      );

    }
    final List<MoviesResponse> loadedMovies = await moviesRepository.getMoviesByQuery(
      MoviesQueryRequest(
        page: page,
        query: query,
      ),
    );
    stopPagination = loadedMovies.isEmpty;
    movies.addAll(loadedMovies);
    emit(
      HomeLoadedState(
        movies: movies,
        moviesSC: moviesSC,
        filterModel: filterModel,
        paginationLoader: false,
      ),
    );
  }



  void searchMovies(String v) async {
    filterModel = null;
    if (v.isEmpty) {
      resetSearchFilter();
    } else {
      if (query != v) {
        query = v;
        type = HomeEnums.search;
        if (_searchDebounce?.isActive ?? false) {
          _searchDebounce!.cancel();
        }
        _searchDebounce = Timer(
          const Duration(seconds: 1),
              () async {
            if (query.isNotEmpty) {
              clearMovies();
              searchMoviesByQuery(query);
            }
          },
        );
      }
    }
  }

  void applyFilter(
      final FilterModel? res, {
        final bool apply = false,
      }) async {
    if (apply) {
      page = 1;
      filterModel = res;
    }
    if (page == 1) {
      emit(HomeMoviesLoadingState());
      clearMovies();
      query = '';
      setFilter();
      type = HomeEnums.filter;
    } else {
      emit(
        HomeLoadedState(
          movies: movies,
          moviesSC: moviesSC,
          filterModel: filterModel,
          paginationLoader: true,
        ),
      );
    }
    final List<MoviesResponse> loadedMovies = await moviesRepository.getMoviesByFilter(
      filterRequest!,
    );
    stopPagination = loadedMovies.isEmpty;
    movies.addAll(loadedMovies);
    emit(
      HomeLoadedState(
        movies: movies,
        moviesSC: moviesSC,
        filterModel: filterModel,
        paginationLoader: false,
      ),
    );
  }

  void initMoviesSC() {
    if (!stopPagination) {
      page += 1;
      currentFunction();
    }
  }

  void currentFunction() {
    switch (type) {
      case HomeEnums.main:
        getAllMovies();
        break;
      case HomeEnums.search:
        searchMoviesByQuery(query);
        break;
      case HomeEnums.filter:
        filterRequest!.page = page;
        applyFilter(filterModel);
        break;
      default:
        log('unsupported');
        break;
    }
  }

  void init() async {
    emit(HomeLoadingState());
    moviesSC = PaginationScrollController(initMoviesSC);
    await getStartMovies();
    emit(
      HomeLoadedState(
        movies: movies,
        moviesSC: moviesSC,
        filterModel: filterModel,
        paginationLoader: false,
      ),
    );
  }


  Future<void> getStartMovies() async {
    final List<MoviesResponse> loadedMovies = await getMovies(
      MoviesRequest(page: page),
    );
    stopPagination = loadedMovies.isEmpty;
    movies.addAll(loadedMovies);
  }


  void resetSearchFilter() {
    query = '';
    filterModel = null;
    type = HomeEnums.main;
    clearMovies();
    getAllMovies(HomeEnums.search);
    emit(
      HomeLoadedState(
        movies: movies,
        moviesSC: moviesSC,
        filterModel: filterModel,
        paginationLoader: false,
      ),
    );
  }



  void setFilter() {
    int? year = int.tryParse(filterModel!.year);
    if (year != null) {
      if (year < 1920 || year > DateTime.now().year) {
        year = null;
      }
    }
    List<String> genresStrings = [];
    for (GenreResponse e in filterModel!.selectedGenres) {
      if (e.id != null) {
        genresStrings.add(e.id.toString());
      }
    }
    final String withGenres = genresStrings.toString().replaceAll('[', '').replaceAll(']', '');
    filterRequest = FilterRequest(
      year: year,
      withGenres: withGenres,
    );
  }

  void clearMovies() {
    page = 1;
    movies.clear();
  }



}
