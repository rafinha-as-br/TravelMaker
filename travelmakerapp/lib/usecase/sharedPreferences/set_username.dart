
import 'package:shared_preferences/shared_preferences.dart';

import '../../entities/user.dart';

Future<void> setUsername(User user,String name, SharedPreferences sharedPreferences) async{
  await sharedPreferences.setString('userName', name);
  user.name = name;
}