import '../entities/comment.dart';
import '../entities/validator.dart';

import 'repositories/repository_comment.dart';

/// adds a comment into the dataBase
Future<Validator> createCommentaryUseCase(
    Comment comment, CommentRepository commentRepo, int stopID
) async{

  //validating comment
  final validate = comment.validateComment(comment);
  if(!validate.success){
    return validate;
  }

  //adding to the database
  final insert = await commentRepo.insertComment(stopID, comment.toMap(stopID));
  if(insert == -1){
    return Validator(false, 'error on adding the comment to database');
  }


  return Validator(true, null);
}
