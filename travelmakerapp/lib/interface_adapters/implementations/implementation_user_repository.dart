import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:travelmakerapp/entities/user.dart';
import '../../entities/validator.dart';
import '../../usecase/repositories/repository_user.dart';

// this is the userRepository implementation,
// implementing all the needings from DataBase & sharedPreferences
class UserRepositoryImpl implements UserRepository {
  final SharedPreferences _prefs;
  final Database db;

  UserRepositoryImpl(this._prefs, this.db);

  final ImagePicker picker = ImagePicker();


  @override
  Future<int> deleteUserDataBase(int userID) async{
    try{
      final id = await db.delete(
        'user',
        where: 'userID = ?',
        whereArgs: [userID],
      );
      return id;
    } catch(e){
      return -1;
    }
  }

  @override
  Future<int> removeUserSharedPreferences() async{

    try{
      await _prefs.remove('userName');
      await _prefs.remove('userAge');
      await _prefs.remove('userID');
      return 1;
    } catch(e){
      return -1;
    }

  }

  @override
  Future<int> insertUserDataBase(Map<String, dynamic> user) async{
    try{
      int userId = await db.insert('user', user);
      return userId;
    } catch(e){
      return -1;
    }
  }

  @override
  Future<Validator> setUserSharedPreferences(User user) async{
    bool setName = await _prefs.setString('userName', user.name);
    bool setAge = await _prefs.setInt('userAge', user.age);
    bool setID = await _prefs.setInt('userID', user.userID!);
    if(user.profilePicturePath != null){
      bool setProfilePic = await _prefs.setString('profilePicturePath', user.profilePicturePath!);
    }

    if(!setName || !setAge || !setID ){
      return Validator(false, 'Error on saving in sharedPrefs');
    }

    return Validator(true, null);
  }

  @override
  Future<int> updateUserDataBase(int id, Map<String, dynamic> user) async{
    try{
      await db.update(
        'user',
        user,
        where: 'userID = ?',
        whereArgs: [id],
      );
      return 1;
    } catch(e){
      return -1;
    }
  }

  @override
  Future<(Validator, User?)> checkExistentUserDataBase() async{
    final user = await db.query('user', limit: 1);
    if(user.isEmpty){
      return (Validator(false, 'no user in dataBase'), null);
    }
    User existentUser = User.fromMap(user.first);

    return (Validator(true, null), existentUser);
  }

  @override
  (Validator, User?) checkExistentUserSharedPrefs(){
    //checking variables in preferences
    final String? name = _prefs.getString('userName');
    final int? age = _prefs.getInt('userAge');
    final int? id = _prefs.getInt('userID');
    final String? profilePic = _prefs.getString('profilePicturePath');

    //returning the validator
    if(name == null || age == null || id == null){
      return (Validator(false, 'No user in sharedPreferences!'), null);
    }

    User user = User(name, age)
      ..userID = id
      ..profilePicturePath = profilePic;

    return (Validator(true, null), user);

  }

  @override
  Future<File?> pickImageFromGallery() async {
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    File? image;
    if (pickedFile != null) {
      image = File(pickedFile.path);
      return image;
    } else{
      return null;
    }

  }

  @override
  Future<File> saveImageLocally(File file) async {
    final appDir = await getApplicationDocumentsDirectory();
    final dataDir = Directory('${appDir.path}/data');

    if (!await dataDir.exists()) {
      await dataDir.create(recursive: true);
    }

    final fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.png';
    final savedPath = '${dataDir.path}/$fileName';

    return await file.copy(savedPath);
  }



}

