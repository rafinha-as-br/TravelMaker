import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelmakerapp/usecase/sharedPreferences/set_userData.dart';

import '../../entities/user.dart';

Future<void> toogleTheme(User user, bool isDark, SharedPreferences sharedPreferences) async{
  user.darkTheme = isDark;
  setUserTheme(user, isDark, sharedPreferences);
  // need a notify listeners after this function

}
