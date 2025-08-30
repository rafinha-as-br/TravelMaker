
import 'package:travelmakerapp/entities/user.dart';
import 'package:travelmakerapp/entities/validator.dart';

import '../view/database/user_repository.dart';

Future<Validator> create_user(User user) async{

  //validating the user
  Validator userValidate =  user.userValidate(user);
  if(!userValidate.success){
    return userValidate;
  }

  //adding to the database

  //gets the implementor of user in dataBase
  final repository = UserRepositoryDataBaseImpl();

  try{
    await repository.insertUser(user.toMap());

    return Validator(true, null);
  }catch (e){
    return Validator(false, 'Error on adding to database');
  }


}
