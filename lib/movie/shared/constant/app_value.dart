import 'package:flutter/material.dart';

class AppValues {
  /// App name
  static const String appName = 'Movies';

  /// Base Url
  static const String baseUrl = 'https://api.themoviedb.org/3/';

  /// Image Url
  static const String imageUrl = 'https://image.tmdb.org/t/p/w500';

  /// Api Key
  static const String apiKey = '61222fdc8669a6536695abd204a053a8';

  /// en lang code
  static const String langCodeEn = 'en';

  /// uk lang code
  static const String langCodeUk = 'uk';

  /// Hero tag for poster
  static const String heroPoster = 'movie_poster';

  /// basic lang code
  static const String langCodeBasic = langCodeEn;

  /// Locale uk
  static const Locale localeUK = Locale(langCodeUk);

  /// Locale en
  static const Locale localeEN = Locale(langCodeEn);

  /// Supported locales (en, de)
  static const List<Locale> supportedLocales = <Locale>[
    localeUK,
    localeEN,
  ];

  /// locales path
  static const String localesPath = 'assets/translations';

}
