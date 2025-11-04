import 'package:shared_preferences/shared_preferences.dart';

class LocalData{
   static String _pin = "1234";
   static String _pattern = "";


   static Future<void> initialize() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _pin = prefs.getString("pin") ?? "";
    _pattern = prefs.getString("pattern") ?? "";

  }

   static Future<void> setPin(String pin) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("pin", pin);
    _pin = pin;
  }

   static String get pin => _pin;

   static Future<void> setPattern(String pattern) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("pattern", pattern);
    _pattern = pattern;
  }

   static String get pattern =>_pattern;


}