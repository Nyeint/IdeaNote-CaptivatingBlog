import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefsProvider =
    Provider<SharedPreferences>((ref) => throw UnimplementedError());

final sharedPrefsHelperProvider =
    Provider((ref) => SharedPrefsHelper(ref.read(sharedPrefsProvider)));

class SharedPrefsHelper {
  final SharedPreferences sharedPreference;
  SharedPrefsHelper(this.sharedPreference);

  get<T>(v) {
    switch (T) {
      case String:
        return sharedPreference.getString(v);
      case bool:
        return sharedPreference.getBool(v);
      case int:
        return sharedPreference.getInt(v);
      case double:
        return sharedPreference.getDouble(v);
      case List:
        return sharedPreference.getStringList(v);
    }
  }

  set<T>(key, value) {
    switch (value.runtimeType) {
      case String:
        return sharedPreference.setString(key, value);
      case bool:
        return sharedPreference.setBool(key, value);
      case int:
        return sharedPreference.setInt(key, value);
      case double:
        return sharedPreference.setDouble(key, value);
      case List:
        return sharedPreference.setStringList(key, value);
    }
  }

  remove(k) {
    return sharedPreference.remove(k);
  }

  clear() {
    return sharedPreference.clear();
  }
}
