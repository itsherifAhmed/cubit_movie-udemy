import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/data_sources/remote/repositories/filter_repo.dart';
import '../../../domain/entities/filter_model.dart';
import '../../../domain/response/genre_response.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterRepository filterRepository;

  FilterCubit(this.filterRepository) : super(FilterInitial());
  String year = '';
  FilterModel? filter;
  List<GenreResponse> genres = [];
  List<GenreResponse> selectedGenres = [];
  void init(final FilterModel? filterModel) async {
    emit(FilterLoading());
    setFilter(filterModel);
    await getGenre();
    emit(
      FilterLoaded (
        year: year ,
        genres: genres,
        selectedGenres: selectedGenres,
      ),
    );
  }

  void setFilter (final FilterModel? filterModel){
    if (filterModel!=null){
      year=filterModel.year;
      selectedGenres=filterModel.selectedGenres;
    }
  }
  bool applyFilter(String year) {
    if (selectedGenres.isNotEmpty) {
      filter = FilterModel(year: year, selectedGenres: selectedGenres);
      return true;
    } else {
      return false;
    }
  }

  Future<void> getGenre() async {
    genres = await filterRepository.getGenres();
  }

  void setGenre({required GenreResponse genre, required bool value}) {
    if (value) {
      selectedGenres.add(genre);
    } else {
      selectedGenres.removeWhere((e) => e.id == genre.id);
    }

    emit(FilterLoaded(
        year: year, genres: genres, selectedGenres: selectedGenres));
  }
}
