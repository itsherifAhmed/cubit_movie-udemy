
import 'package:cubit_movies/movie/presentation/router/approutes.dart';
import 'package:cubit_movies/movie/presentation/ui/splash/splash_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/constant/string_keys.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashCubit, SplashState>(
      bloc: SplashCubit(goHome: ()=>context.go(AppRoutes.home)),
      builder: (BuildContext context,SplashState state) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset("assets/images/app_icon.png"),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    StringsKeys.movies.tr(),
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline1,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
