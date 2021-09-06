import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

const userToken = 'user_token';
const defaultLanguage = 'default_language';
const loginPin = 'login_pin';
const BIOMETRIC_AUTH_ENABLED = 'bio_enabled';

@lazySingleton
class LocalStorage {
  final SharedPreferences sharedPreferences;

  LocalStorage(this.sharedPreferences);
  String? getString(String key) => sharedPreferences.getString(key);
  Future<bool> saveString(String key, String value) =>
      sharedPreferences.setString(key, value);

  bool? getBool(String key) => sharedPreferences.getBool(key);
  Future<bool> saveBool(String key, bool value) =>
      sharedPreferences.setBool(key, value);
}
