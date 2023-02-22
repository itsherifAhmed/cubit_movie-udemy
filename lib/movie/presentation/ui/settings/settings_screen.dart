
import 'package:cubit_movies/movie/presentation/ui/settings/settings_cubit.dart';
import 'package:cubit_movies/movie/presentation/ui/settings/settings_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/constant/string_keys.dart';
import '../../../shared/widgets/app_progress.dart';
import '../../../shared/widgets/widgets.dart';
import '../../di/di.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  final SettingsCubit _settingsCubit = getIt.get<SettingsCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      bloc: _settingsCubit,
      builder: (BuildContext context, SettingsState state) {
        if (state is SettingsLoadingState) {
          return const ProgressAreaWidget();
        } else if (state is SettingsErrorState) {
          return const AppErrorWidget(
            showBack: true,
          );
        } else if (state is SettingsLoadedState) {
          return _buildSettings(
            context: context,
            state: state,
          );
        } else {
          return const Offstage();
        }
      },
    );
  }

  Widget _buildSettings({
    required BuildContext context,
    required SettingsLoadedState state,
  }) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(StringsKeys.settings.tr()),
        bottom: appBarDivider(),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 1200,
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 20.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
