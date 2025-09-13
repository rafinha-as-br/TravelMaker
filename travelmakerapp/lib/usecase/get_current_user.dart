
// this useCase return a user or a null, used for cheking if there is a user or
// to get a user in anyScreen
import 'package:travelmakerapp/entities/validator.dart';
import 'package:travelmakerapp/usecase/repositories/repository_user.dart';
import '../entities/user.dart';

Future<User?> getCurrentUserUseCase(UserRepository userRepo) async{
  // check in sharedPrefs, if is not existent in it, then check in dataBase
  // obs: it only checks in database and sharedPrefs because there is the
  // possibility of the user cleaning the cache of the app!

   final checkSharedPrefs = userRepo.checkExistentUserSharedPrefs();
   if(!checkSharedPrefs.$1.success){
     final checkDataBase = await userRepo.checkExistentUserDataBase();
     if(!checkDataBase.$1.success){
       return null;
     }

     // if the database Contains the user but sharedPreferences don't, then the
     // app should update the sharedPreferences with the dataBase infos,
     // and then returning an User

     Validator resavingUserInPrefs = await userRepo.setUserSharedPreferences(checkDataBase.$2!);
     if(!resavingUserInPrefs.success){
       return null;
     }
     return checkDataBase.$2;
   }

   return checkSharedPrefs.$2;






}