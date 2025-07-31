import 'package:travelmakerapp/usecase/sharedPreferences/sharedPreferencesInstance.dart';
import '../../entities/user.dart';

Future<void> clearUserData(User user) async{
  final sharedPreferences = SharedPreferencesInstance().preferences;

  await sharedPreferences.remove('userName');
  user.name = null;

  await sharedPreferences.remove('userAge');
  user.age = null;

  await sharedPreferences.remove('userAtive');
  user.ative = false;

  await sharedPreferences.remove('darkTheme');
  user.darkTheme = false;

  await sharedPreferences.remove('languageCode');
  user.language = 'pt';

  // need an notifyListeners after this function
}