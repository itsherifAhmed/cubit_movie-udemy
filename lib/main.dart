
import 'package:easy_localization/easy_localization.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'movie/data/data_sources/local/prefrance.dart';
import 'movie/presentation/di/di.dart';
import 'movie/presentation/router/approuter.dart';
import 'movie/presentation/router/approutes.dart';
import 'movie/shared/constant/app_value.dart';
import 'movie/shared/style/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  setup();
  await Hive.initFlutter();
  await getIt<Preferences>().openBox();
  if (kIsWeb) {
    setPathUrlStrategy();
    SystemNavigator.routeInformationUpdated(
      location: AppRoutes.splash,
    );
  }
  runApp(
    EasyLocalization(
      supportedLocales: AppValues.supportedLocales,
      path: AppValues.localesPath,
      fallbackLocale: AppValues.localeEN,
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return OverlaySupport.global(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: AppValues.appName,
        theme: AppThemes.getTheme(),
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        routerDelegate: AppRouter.router.routerDelegate,
        routeInformationParser: AppRouter.router.routeInformationParser,
      ),
    );
  }
}
