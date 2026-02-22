import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  // 1. Make the fields static and private
  static String _name = "";
  static bool _firstTime = true;
  static int _totalBalance = 0;
  static int _income = 0;
  static int _expenses = 0;

  // 2. Make the getters static
  static String get name => _name;
  static bool get firstTime => _firstTime;
  static int get totalBalance => _totalBalance;
  static int get income => _income;
  static int get expenses => _expenses;


  // 3. Static initialization
  static Future<void> initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _name = prefs.getString("name") ?? "";
    _firstTime = prefs.getBool("firstTime") ?? true;
    _totalBalance = prefs.getInt("totalBalance") ?? 0;
    _income = prefs.getInt("income") ?? 0;
    _expenses = prefs.getInt("expenses") ?? 0;
  }

  // 4. Use setters to keep it clean
  static set name(String value) {
    _name = value;
    _saveToPrefs("name", value);
  }

  static set firstTime(bool value) {
    _firstTime = value;
    _saveToPrefs("firstTime", value);
  }
  static set totalBalance(int value) {
    _totalBalance = value;
    _saveToPrefs("totalBalance", value);
  }
  static set income(int value) {
    _income = value;
    _saveToPrefs("income", value);
  }

  static set expenses(int value) {
    _expenses = value;
    _saveToPrefs("expenses", value);
  }

  // Helper to persist data automatically
  static Future<void> _saveToPrefs(String key, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is String) await prefs.setString(key, value);
    if (value is bool) await prefs.setBool(key, value);
    if(value is int) await prefs.setInt(key, value);
  }
}