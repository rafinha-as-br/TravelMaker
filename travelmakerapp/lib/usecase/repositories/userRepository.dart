import '../../entities/user.dart';
import '../../entities/validator.dart';

// the user Repository contains methods that saves in sharedPreferences
abstract class UserRepository {
  Future<Validator> createUser(User user);
  Future<User?> getCurrentUser();
  Future<void> setCurrentUser(User user);
  Future<void> clearUser();
  Future<void> setUserProfilePicture(User user);


  // save user in sharedPreferences
  // save user in dataBase

}
