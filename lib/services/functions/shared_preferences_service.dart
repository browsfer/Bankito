import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferences? _preferences;

  // Initialize SharedPreferences instance
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Save the balance value
  static Future<void> saveBalance(int balance) async {
    if (_preferences == null) {
      await init();
    }
    await _preferences!.setInt('balance', balance);
  }

  // Retrieve the balance value
  static Future<int> getBalance() async {
    if (_preferences == null) {
      await init();
    }
    return _preferences!.getInt('balance') ?? 0;
  }
}
