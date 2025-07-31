import 'package:shared_preferences/shared_preferences.dart';

import '../../entities/user.dart';

Future<void> toogleTheme(User user, bool isDark, SharedPreferences sharedPreferences) async{
  user.darkTheme = isDark;
  await sharedPreferences.setBool('darkTheme', isDark);
  // need a notify listeners after this function

}
