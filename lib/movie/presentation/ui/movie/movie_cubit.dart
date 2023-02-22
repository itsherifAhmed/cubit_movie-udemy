
import 'package:cubit_movies/movie/domain/response/movie_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data_sources/remote/repositories/movie_repo.dart';
import '../../../domain/request/movie_deatiul_requesy.dart';
import '../../../domain/response/movies_response.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MoviesRepository moviesRepository;

  MovieCubit(this.moviesRepository) : super(MovieInitialState());

  Future<void > getMovie (final int? movieId)async{
    if (movieId==null){
      emit(MovieErrorState());
    }
    else {
      emit(MovieLoadingState());
      final MovieResponse? loadedMovie=await moviesRepository.getMovie(MovieRequest(movieId: movieId));
      if (loadedMovie==null){
        emit(MovieErrorState());
      }
      emit(MovieLoadedState(movieResponse: loadedMovie));
    }
  }
}
