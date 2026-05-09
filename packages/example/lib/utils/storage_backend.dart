import 'package:mantine/mantine.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesBackend implements MantineStorageBackend {
  const SharedPreferencesBackend();

  @override
  Future<String?> getItem(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  @override
  Future<void> setItem(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  @override
  Future<void> removeItem(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
