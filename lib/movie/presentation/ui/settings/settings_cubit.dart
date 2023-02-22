
import 'package:cubit_movies/movie/presentation/ui/settings/settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data_sources/local/prefrance.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final Preferences _pref;

  SettingsCubit(
    this._pref,
  ) : super(SettingsLoadingState()) {
    init();
  }

  void init() {
    emit(SettingsLoadedState());
  }
}
