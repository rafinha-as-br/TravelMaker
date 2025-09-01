
import 'package:travelmakerapp/entities/user.dart';
import 'package:travelmakerapp/entities/validator.dart';
import 'package:travelmakerapp/usecase/repositories/userRepository.dart';

Future<Validator> createUserUseCase(
    User user,
    UserRepository userRepository,) async
{

  //validating the user
  Validator userValidate =  user.userValidate(user);
  if(!userValidate.success){
    return userValidate;
  }

  //adds to the dataBase and receives the created userID from the DataBase
  int userID = await userRepository.saveUserDataBase(user.toMap());
  //checks if there is any error on insert, send another validator
  if(userID == -1){
    return Validator(false, 'error on insert!');
  }
  
  // updates the user instance with this id
  user.userID = userID;

  // adds to sharedPreferences
  final saveSharedPrefs = await userRepository.saveUserSharedPreferences(user);
  if(!saveSharedPrefs.success){
    return saveSharedPrefs;
  }

  return Validator(true, null);
}
