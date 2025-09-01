import 'package:travelmakerapp/entities/validator.dart';
import 'package:travelmakerapp/usecase/repositories/user_repository.dart';

import '../entities/user.dart';

Future<Validator> updateUserUseCase(
    UserRepository userRepo,
    User user
    ) async
{
  final userMap = user.toMap();
  int userID = user.userID!;
  int userDataBaseUpdate = await userRepo.updateUserDataBase(userID, userMap);
  if(userDataBaseUpdate==-1){
    return Validator(false, 'Error on update user on database!');
  }

  final updateUserPrefs = await userRepo.setUserSharedPreferences(user);
  if(!updateUserPrefs.success){
    return updateUserPrefs;
  }

  return Validator(true, null);

}