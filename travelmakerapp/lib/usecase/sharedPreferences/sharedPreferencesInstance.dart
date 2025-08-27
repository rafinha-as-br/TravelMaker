import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesInstance {
  static final SharedPreferencesInstance _instance = SharedPreferencesInstance._internal();

  SharedPreferences? _preferences;


  factory SharedPreferencesInstance() {
    return _instance;
  }

  SharedPreferencesInstance._internal();

  // init constructor (called on the start of main.dart)
  Future<void> init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  SharedPreferences get preferences {
    if (_preferences == null) {
      throw Exception(
          'init() needs to be called before accessing preferences'
      );
    }
    return _preferences!;
  }
}
