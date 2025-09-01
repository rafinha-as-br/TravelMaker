import 'package:travelmakerapp/usecase/repositories/userRepository.dart';

import '../entities/user.dart';
import '../entities/validator.dart';
import 'get_current_user.dart';

Future<Validator> removeUserUseCase(
    UserRepository userRepo
    ) async {
  //get the userID from getCurrentUserUseCase
  User? currentUser = await getCurrentUserUseCase(userRepo);
  int userID = currentUser!.userID!;

  // remove from database
  int userRemoveDb = await userRepo.removeUserDataBase(userID);
  if (userRemoveDb == -1) {
    return Validator(false, 'error on removing user from database');
  }

  // remove from sharedPreferences
  int userRemovePref = await userRepo.removeUserSharedPreferences();
  if (userRemovePref == -1) {
    return Validator(false, 'error no removing user from shared preferences');
  }

  return Validator(true, null);
}
