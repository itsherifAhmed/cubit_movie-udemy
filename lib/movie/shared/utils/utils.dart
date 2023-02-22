import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:overlay_support/overlay_support.dart';

import '../constant/app_value.dart';

void errorToast({
  required String? code,
  required String? message,
}) {
  toast(
    getClearName(code, message, comma: true),
    duration: const Duration(milliseconds: 1400),
  );
}

bool isApple() {
  return defaultTargetPlatform == TargetPlatform.macOS || defaultTargetPlatform == TargetPlatform.iOS;
}

bool isMobile() {
  return defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS;
}

double doubleParser(dynamic data) {
  final double? doubleResult = double.tryParse(data.toString());
  if (doubleResult != null) {
    return doubleResult;
  } else {
    return 0.0;
  }
}

String getClearName(String? firstName, String? lastName, {bool comma = false}) {
  return (firstName ?? '') + (firstName == null ? '' : firstName.isEmpty ? ''
      : comma ? lastName == null ? '' : lastName.isEmpty ? '' : ', ' : ' ')
      + (lastName ?? '');
}

String getLangCode() {
  try {
    switch (window.locale.languageCode) {
      case AppValues.langCodeUk:
        return AppValues.langCodeUk;
      case AppValues.langCodeEn:
        return AppValues.langCodeEn;
      default:
        return AppValues.langCodeBasic;
    }
  } catch (e) {
    return AppValues.langCodeBasic;
  }
}

Future<void> futureDelayed({int milliseconds = 1000}) async {
  await Future.delayed(Duration(milliseconds: milliseconds));
}
