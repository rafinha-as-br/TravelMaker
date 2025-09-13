
import '../entities/comment.dart';
import '../entities/person.dart';
import '../entities/validator.dart';
import 'repositories/repository_comment.dart';
import 'repositories/repository_person.dart';

/// get comments by stopID
Future<(Validator, List<Comment>)> getCommentsUseCase(
  int stopID, CommentRepository commentRepo, PersonRepository personRepo
) async {
  var commentsList = <Comment>[];

  try {

    //get the comments by stopID
    final comments = await commentRepo.getCommentsByStop(stopID);


    for(final comment in comments){
      final personID = comment['person_id'];
      final personMap = await personRepo.getPersonById(personID);
      if(personMap == null){
        return (Validator(false, 'error on getting the person'), commentsList);
      }
      final person = Person.fromMap(personMap);

      final c = Comment(text: comment['comm_text'], person: person);

      commentsList.add(c);

    }

    return (Validator(true, null), commentsList);
  } on Exception catch (e) {
    return (Validator(false, 'e'), commentsList);
  }

}