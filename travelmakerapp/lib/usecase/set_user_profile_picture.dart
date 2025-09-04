

import 'dart:io';
import 'package:travelmakerapp/usecase/repositories/user_repository.dart';


Future<String?> setUserProfilePictureUseCase(
    UserRepository userRepo
  ) async
{
  //get image
  File? file = await userRepo.pickImageFromGallery();

  if(file == null){
    return null;
  }

  //saving locally
  userRepo.saveImageLocally(file);

  //get the path
  String? profilePicturePath = file.path.toString();


  // returns the string path to save on dataBase on another function!
  return profilePicturePath;


}