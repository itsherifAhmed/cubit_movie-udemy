
import 'package:cubit_movies/movie/presentation/ui/filter/widgets/filter_title_item.dart';
import 'package:cubit_movies/movie/presentation/ui/filter/widgets/genre_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/filter_model.dart';
import '../../../domain/response/genre_response.dart';
import '../../../shared/constant/string_keys.dart';
import '../../../shared/style/colors.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_progress.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/widgets.dart';
import '../../di/di.dart';
import 'filter_cubit.dart';

Future<FilterModel?> showFilterBottomSheet({
  required BuildContext context,
  required FilterModel? filter,
}) async {
  final FilterModel? res = await showModalBottomSheet<FilterModel?>(
    context: context,
    isScrollControlled: true,
    clipBehavior: Clip.hardEdge,
    backgroundColor: Theme.of(context).dialogBackgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(22),
        topRight: Radius.circular(22),
      ),
    ),
    builder: (BuildContext context) {
      return FractionallySizedBox(
        heightFactor: 0.9,
        child: FilterScreen(
          filter: filter,
        ),
      );
    },
  );
  return res;
}

Future<FilterModel?> showFilterAlertDialog({
  required BuildContext context,
  required FilterModel? filter,
}) async {
  final FilterModel? res = await showDialog<FilterModel?>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        clipBehavior: Clip.hardEdge,
        contentPadding: EdgeInsets.zero,
        backgroundColor: Theme.of(context).dialogBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        content: SizedBox(
          width: 1000,
          child: FilterScreen(
            filter: filter,
          ),
        ),
      );
    },
  );
  return res;
}

class FilterScreen extends StatelessWidget {
  final FilterModel? filter;

  FilterScreen({
    Key? key,
    required this.filter,
  }) : super(key: key);

  final FilterCubit _filterCubit = getIt.get<FilterCubit>();
  final FocusNode _yearFN = FocusNode();
  final TextEditingController _yearTC = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(
      bloc: _filterCubit..init(filter),
      builder: (BuildContext context, FilterState state) {
        return GestureDetector(
          onTap: unFocus,
          child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Theme.of(context).dialogBackgroundColor,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(StringsKeys.filter.tr()),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1),
                child: Divider(
                  thickness: 1,
                  height: 1,
                  indent: 0,
                  color: AppColors.grey.withOpacity(0.4),
                ),
              ),
              backgroundColor: Theme.of(context).dialogBackgroundColor,
              actions: [
                Padding(
                  padding: MediaQuery.of(context).size.width >= 540 ?
                  const EdgeInsets.only(
                    right: 8,
                  ) : EdgeInsets.zero,
                  child: IconButton(
                    tooltip: StringsKeys.close.tr(),
                    icon: const Icon(Icons.clear),
                    onPressed: () => Navigator.pop(context),
                  ),
                )
              ],
            ),
            body: SizedBox(
              width: double.infinity,
              child: Builder(
                builder: (BuildContext context) {
                  if (state is FilterLoading ) {
                    return const AppProgress();
                  } else if (state is FilterError) {
                    return const AppErrorWidget();
                  } else if (state is FilterLoaded ) {
                    _yearTC.text = state.year;
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 22,
                          right: 22,
                          top: 22,
                          bottom: 80,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const FilterTitleItem(
                              title: StringsKeys.year,
                            ),
                            SizedBox(
                              width: 120,
                              child: AppTextField(
                                maxLines: 1,
                                controller: _yearTC,
                                focusNode: _yearFN,
                                hint: StringsKeys.enterYear.tr(),
                                keyboardType: TextInputType.number,
                                backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
                                onChanged: (v) => _filterCubit.year = v,
                                padding: const EdgeInsets.only(
                                  top: 6,
                                  bottom: 26,
                                ),
                                inputFormatters: [

                                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                                ],
                              ),
                            ),
                            const FilterTitleItem(
                              title: StringsKeys.genres,
                            ),
                            Wrap(
                              children: state.genres.map((genre) {
                                return GenreItem(
                                  value: _checkGenre(
                                    genre: genre,
                                    selected: state.selectedGenres,
                                  ),
                                  title: genre.name,
                                  onChanged: (value) => _filterCubit.setGenre(
                                    value: value ?? false,
                                    genre: genre,
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const Offstage();
                  }
                },
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Offstage(
              offstage: _filterCubit.selectedGenres.isEmpty,
              child: AppButton(
                title: StringsKeys.apply.tr().toUpperCase(),
                onTap: () {
                  final bool res = _filterCubit.applyFilter(_yearTC.text);
                  if (res) {
                    Navigator.pop(context, _filterCubit.filter);
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }

  bool _checkGenre({
    required GenreResponse genre,
    required List<GenreResponse> selected,
  }) {
    Iterable<GenreResponse> res = selected.where((e) => e.id == genre.id);
    return res.isNotEmpty;
  }

  void unFocus() => _yearFN.unfocus();
}
