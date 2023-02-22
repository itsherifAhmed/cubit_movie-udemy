import 'package:hive/hive.dart';


class Preferences {
  static const String _preferencesBox = '_preferencesBox';

  Box<dynamic>? _box;

  /// Open Box
  Future<void> openBox() async => _box = await Hive.openBox<dynamic>(_preferencesBox);

  /// Get Value
  // Future<T> _getValue<T>(dynamic key, {T? defaultValue}) async => await _box!.get(key, defaultValue: defaultValue) as T;

  /// Set Value
  // Future<void> _setValue<T>(dynamic key, T value) async => await _box!.put(key, value);

  /// Clear Cache
  Future<void> clearCache() async => await _box!.clear();

}

///VM
///BLOC