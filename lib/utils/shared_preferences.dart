import 'package:shared_preferences/shared_preferences.dart';
part 'const.dart';

class Sp{
  static void saveDataString(String key, String data) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, data);
  }
  static Future<String> storeDataString(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key) ?? "";
  }

  static void removeData(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(key);
  }
}