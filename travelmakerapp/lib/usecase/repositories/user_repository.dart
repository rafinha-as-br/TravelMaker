import 'dart:io';

import '../../entities/user.dart';
import '../../entities/validator.dart';

// the user Repository contains methods that saves in sharedPreferences and database
abstract class UserRepository {

  // save user in dataBase
  Future<int> insertUserDataBase(Map<String, dynamic> user);
  // save & update user in sharedPreferences user in sharedPreferences
  Future<Validator> setUserSharedPreferences(User user);


  // update user in database
  Future<int> updateUserDataBase(int id, Map<String, dynamic> user);


  // remove user from sharedPreferences
  Future<int> removeUserSharedPreferences();
  // remove user from database
  Future<int> deleteUserDataBase(int userID);


  // check possible existent user in sharedPreferences
  (Validator, User?) checkExistentUserSharedPrefs();

  // check possible existent user in dataBase
  Future<(Validator, User?)> checkExistentUserDataBase();

  // to ask the user for a image from gallery
  Future<File?> pickImageFromGallery();

  Future<File> saveImageLocally(File file);


}
