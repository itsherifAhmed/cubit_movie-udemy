import 'package:cubit_movies/movie/shared/core/base/pageintation_scroll_controller.dart';
import 'package:flutter/material.dart';

import '../../enums/scroll_view_enums.dart';
import '../../widgets/app_progress.dart';

class PaginationScrollView extends StatelessWidget {
  final PaginationScrollController scrollController;
  final ScrollViewEnums type;
  final bool paginationLoader;
  final EdgeInsetsGeometry padding;
  final List<Widget> children;

  const PaginationScrollView({
    Key? key,
    required this.scrollController,
    required this.type,
    required this.paginationLoader,
    required this.padding,
    required this.children,
  }) : super(key: key);

  Widget _buildByType(BuildContext context) {
    switch (type) {
      case ScrollViewEnums.wrap:
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth > 1000) {
              return _wrapView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.55,
                ),
              );
            } else if (constraints.maxWidth > 600) {
              return _wrapView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.55,
                ),
              );
            } else {
              return _wrapView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.55,
                ),
              );
            }
          },
        );
      case ScrollViewEnums.column:
      default:
        return ListView.builder(
          padding: padding,
          controller: scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: children.length,
          itemBuilder: (_, int i) {
            return children[i];
          },
        );
    }
  }

  Widget _wrapView({
    required SliverGridDelegate gridDelegate,
  }) {
    return GridView.builder(
      padding: padding,
      controller: scrollController,
      gridDelegate: gridDelegate,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: children.length,
      itemBuilder: (_, int i) {
        return children[i];
      },
    );
  }

  Widget _loader() {
    return Offstage(
      offstage: !paginationLoader,
      child: const Padding(
        padding: EdgeInsets.only(top: 24, bottom: 28),
        child: AppProgress(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: _buildByType(context),
        ),
        _loader(),
      ],
    );
  }
}

