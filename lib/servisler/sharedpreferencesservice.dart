import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String _temaKey = 'isDarkMode';

  Future<void> temaKaydet(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_temaKey, isDarkMode);
  }

  Future<bool> temaGetir() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_temaKey) ?? false;
  }
}