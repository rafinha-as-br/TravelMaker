import '../../entities/user.dart';

abstract class UserRepository {
  Future<User?> getCurrentUser();
  Future<void> setCurrentUser(User user);
  Future<void> clearUser();
  Future<void> setUsername(User user, String name);
  Future<void> setUserAge(User user, int age);
  Future<void> setUserActive(User user, bool active);
  Future<void> setUserLanguage(User user, String languageCode);
  Future<void> setUserTheme(User user, bool isDark);
  Future<void> setUserProfilePicture(User user);
  Future<void> setUserData(User user, String name, int age, bool active);
  Future<int> toggleLanguage(User user, int languageN);

}
