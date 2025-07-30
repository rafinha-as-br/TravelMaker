import 'package:shared_preferences/shared_preferences.dart';

import '../../entities/user.dart';

Future<void> SharedStartUp(User user, SharedPreferences sharedPreferences) async{
  sharedPreferences = await SharedPreferences.getInstance();
  user.name = sharedPreferences.getString('userName');
  user.age = sharedPreferences.getInt('userAge');
  user.ative = sharedPreferences.getBool('userAtive') ?? false;
  user.darkTheme = sharedPreferences.getBool('darkTheme') ?? false;
  user.language = sharedPreferences.getString('languageCode') ?? 'pt';

  // *** don't forget the notifyListeners below the call of this function
}