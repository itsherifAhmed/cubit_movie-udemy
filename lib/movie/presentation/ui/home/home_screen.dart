
import 'package:cubit_movies/movie/presentation/ui/home/widgets/movie_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/filter_model.dart';
import '../../../domain/response/movies_response.dart';
import '../../../shared/constant/string_keys.dart';
import '../../../shared/core/base/pageinitation_scroll_scroller_view.dart';
import '../../../shared/enums/scroll_view_enums.dart';
import '../../../shared/style/colors.dart';
import '../../../shared/utils/utils.dart';
import '../../../shared/widgets/app_progress.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/icon_button_widget.dart';
import '../../../shared/widgets/widgets.dart';
import '../../di/di.dart';
import '../../router/approutes.dart';
import '../../router/arguments.dart';
import '../filter/filter_dialog.dart';
import 'home_cubit.dart';
import 'home_enum.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeCubit _homeCubit;
  late final FocusNode _searchFN;
  late final TextEditingController _searchTC;
  late final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    _homeCubit = getIt.get<HomeCubit>();
    _searchFN = FocusNode();
    _searchTC = TextEditingController();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1200,
          ),
          child: BlocBuilder<HomeCubit, HomeState>(
            bloc: _homeCubit,
            builder: (BuildContext context, HomeState state) {
              if (state is HomeLoadingState) {
                return const SafeArea(
                  child: AppProgress(),
                );
              } else if (state is HomeErrorState) {
                return const AppErrorWidget();
              } else if (state is HomeLoadedState || state is HomeMoviesLoadingState) {
                return GestureDetector(
                  onTap: unFocus,
                  child: Scaffold(
                    key: _scaffoldKey,
                    appBar: AppBar(
                      title: Text(
                        StringsKeys.movies.tr(),
                      ),
                      actions: [
                        Padding(
                          padding: MediaQuery.of(context).size.width >= 1200 ? const EdgeInsets.only(
                            right: 46,
                          ) : EdgeInsets.zero,
                          child: IconButton(
                            tooltip: StringsKeys.settings.tr(),
                            icon: const Icon(Icons.settings_outlined),
                            onPressed: () {
                              unFocus();
                              context.push(AppRoutes.setting);
                            },
                          ),
                        ),
                      ],
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(70),
                        child: Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: AppTextField(
                                  controller: _searchTC,
                                  focusNode: _searchFN,
                                  hint: StringsKeys.search.tr(),
                                  maxLines: 1,
                                  suffix: Offstage(
                                    offstage: _homeCubit.query.isEmpty,
                                    child: IconButtonWidget(
                                      tooltip: StringsKeys.clear.tr(),
                                      icon: Icons.clear,
                                      buttonSize: 42,
                                      onPressed: () {
                                        _searchTC.clear();
                                        _homeCubit.resetSearchFilter();
                                      },
                                    ),
                                  ),
                                  onChanged: (v) => _homeCubit.searchMovies(v),
                                ),
                              ),
                              Offstage(
                                offstage: _homeCubit.type != HomeEnums.filter,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    right: 12,
                                  ),
                                  child: IconButtonWidget(
                                    tooltip: StringsKeys.clear.tr(),
                                    icon: Icons.clear,
                                    buttonSize: isMobile() ? 50 : 57,
                                    onPressed: _homeCubit.resetSearchFilter,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 12,
                                ),
                                child: IconButtonWidget(
                                  tooltip: StringsKeys.filter.tr(),
                                  icon: Icons.filter_alt_outlined,
                                  color: _homeCubit.type == HomeEnums.filter ? Theme.of(context).primaryColor : null,
                                  buttonSize: isMobile() ? 50 : 57,
                                  onPressed: () async {
                                    if (state is HomeLoadedState) {
                                      final FilterModel? res = MediaQuery.of(context).size.width >= 1200 ?
                                      await showFilterAlertDialog(
                                        context: _scaffoldKey.currentContext ?? context,
                                        filter: state.filterModel,
                                      ) : await showFilterBottomSheet(
                                        context: _scaffoldKey.currentContext ?? context,
                                        filter: state.filterModel,
                                      );
                                      if (res != null) {
                                        _searchTC.clear();
                                        _homeCubit.applyFilter(
                                          res,
                                          apply: true,
                                        );
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    body: Container(
                      width: double.infinity,
                      height: double.infinity,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(18),
                          topRight: Radius.circular(18),
                        ),
                      ),
                      child: RefreshIndicator(
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        onRefresh: () async {
                          _searchTC.clear();
                          _homeCubit.resetSearchFilter();
                        },
                        child: Builder(
                          builder: (context) {
                            if (state is HomeLoadedState) {
                              return _buildMovies(
                                context: context,
                                state: state,
                                unFocus: unFocus,
                              );
                            } else if (state is HomeMoviesLoadingState) {
                              return const AppProgress();
                            } else {
                              return const Offstage();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return const Offstage();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMovies({
    required BuildContext context,
    required HomeLoadedState state,
    required void Function() unFocus,
  }) {
    return state.movies.isEmpty ? const AppErrorWidget(
      title: StringsKeys.noMovies,
      backgroundColor: AppColors.transparent,
    ) : PaginationScrollView(
      scrollController: state.moviesSC,
      type: ScrollViewEnums.wrap,
      paginationLoader: state.paginationLoader,
      padding: const EdgeInsets.symmetric(
        vertical: 26.0,
        horizontal: 8.0,
      ),
      children: state.movies.map((MoviesResponse movie) {
        return MovieItem(
          movie: movie,
          onTap: () {
            unFocus();
            context.push(
              AppRoutes.movie,
              extra: MovieArguments(
                movieId: movie.id,
                posterPath: movie.posterPath,
                title: movie.title,
                voteAverage: movie.voteAverage,
              ),
            );
          },
        );
      }).toList(),
    );
  }

  void unFocus() => _searchFN.unfocus();
}
