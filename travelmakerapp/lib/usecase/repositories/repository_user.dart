import 'dart:io';

import '../../entities/user.dart';
import '../../entities/validator.dart';

/// contract repository for user storage on database and shared Preferences
abstract class UserRepository {

  /// to save user in dataBase
  Future<int> insertUserDataBase(Map<String, dynamic> user);

  /// to save & update user in sharedPreferences user in sharedPreferences
  Future<Validator> setUserSharedPreferences(User user);

  /// to update user in database
  Future<int> updateUserDataBase(int id, Map<String, dynamic> user);

  /// to remove user from sharedPreferences
  Future<int> removeUserSharedPreferences();

  /// to remove user from database
  Future<int> deleteUserDataBase(int userID);

  /// to check possible existent user in sharedPreferences
  (Validator, User?) checkExistentUserSharedPrefs();

  /// to check possible existent user in dataBase
  Future<(Validator, User?)> checkExistentUserDataBase();

  /// to ask the user for a image from gallery
  Future<File?> pickImageFromGallery();

  /// to save user profile picture locally
  Future<File> saveImageLocally(File file);


}
