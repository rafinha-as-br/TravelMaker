import '../../entities/user.dart';
import '../../entities/validator.dart';

// the user Repository contains methods that saves in sharedPreferences and database
abstract class UserRepository {
  Future<Validator> createUser(User user);
  Future<User?> getCurrentUser();
  Future<void> setCurrentUser(User user);
  Future<void> clearUser();
  Future<void> setUserProfilePicture(User user);


  // ----- user persistence methods ------
  // save user in dataBase
  Future<void> saveUserDataBase(User user);
  // save user in sharedPreferences
  Future<void> saveUserSharedPreferences(User user);


  // update user in sharedPreferences
  Future<void> updateUserSharedPreferences(User user);
  // update user in database
  Future<void> updateUserDataBase(User user);


  // remove user from sharedPreferences
  Future<void> removeUserSharedPreferences(User user);
  // remove user from database
  Future<void> removeUserDataBase(User user);

}
