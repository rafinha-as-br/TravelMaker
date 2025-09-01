
import 'package:travelmakerapp/entities/user.dart';
import 'package:travelmakerapp/entities/validator.dart';
import 'package:travelmakerapp/usecase/repositories/userRepository.dart';
import 'package:travelmakerapp/usecase/repositories/user_repository_database.dart';

Future<(Validator, User?)> create_user(
    User user,
    UserRepository userRepository,
    UserRepositoryDataBase userDataBase) async
{

  //validating the user
  Validator userValidate =  user.userValidate(user);
  if(!userValidate.success){
    return (userValidate, null);
  }

  //adds to the dataBase and receives the created userID from the DataBase
  int userID = await userDataBase.insertUser(user.toMap());
  // updates the user instance with this id
  user.userID = userID;

  // adds to sharedPreferences


  return (Validator(true, null), user);
}
