
import 'package:travelmakerapp/entities/user.dart';
import 'package:travelmakerapp/entities/validator.dart';

Future<Validator> create_user(User user) async{

  //validating the user
  Validator userValidate =  user.userValidate(user);
  if(!userValidate.success){
    return userValidate;
  }

  return Validator(true, null);
}
