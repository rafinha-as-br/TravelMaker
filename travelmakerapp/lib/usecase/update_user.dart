import 'package:travelmakerapp/entities/validator.dart';
import 'package:travelmakerapp/usecase/repositories/user_repository.dart';

import '../entities/user.dart';

Future<Validator> updateUserUseCase(
    UserRepository userRepo,
    User user
    ) async
{
  // validating the user
  final validateUser = user.userValidate(user);
  if(!validateUser.success){
    return validateUser;
  }

  // saves in DataBase
  final userMap = user.toMap();
  int userID = user.userID!;
  int userDataBaseUpdate = await userRepo.updateUserDataBase(userID, userMap);
  if(userDataBaseUpdate==-1){
    return Validator(false, 'Error on update user on database!');
  }

  // saves in sharedPrefs
  final updateUserPrefs = await userRepo.setUserSharedPreferences(user);
  if(!updateUserPrefs.success){
    return updateUserPrefs;
  }


  return Validator(true, null);

}