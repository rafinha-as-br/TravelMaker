import '../../entities/user.dart';
import '../../entities/validator.dart';

// the user Repository contains methods that saves in sharedPreferences and database
abstract class UserRepository {

  // save user in dataBase
  Future<int> saveUserDataBase(Map<String, dynamic> user);
  // save user in sharedPreferences
  Future<Validator> saveUserSharedPreferences(User user);


  // update user in sharedPreferences
  Future<void> updateUserSharedPreferences(User user);

  // update user in database
  Future<void> updateUserDataBase(User user);


  // remove user from sharedPreferences
  Future<void> removeUserSharedPreferences(User user );
  // remove user from database
  Future<int> removeUserDataBase(User user );


  // check possible existent user in sharedPreferences
  (Validator, User?) checkExistentUserSharedPrefs();

  // check possible existent user in dataBase
  Future<(Validator, User?)> checkExistentUserDataBase();

}
