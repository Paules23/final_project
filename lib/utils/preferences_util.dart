import 'package:shared_preferences/shared_preferences.dart';

class PreferencesUtil {
  static SharedPreferences? _prefs;

  static Future<SharedPreferences> get prefs async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  static Future<List<String>> getFavoriteIds() async {
    final sharedPreferences = await prefs;
    return sharedPreferences.getStringList('favorites') ?? [];
  }

  static Future<void> setFavoriteIds(List<String> ids) async {
    final sharedPreferences = await prefs;
    await sharedPreferences.setStringList('favorites', ids);
  }
}
