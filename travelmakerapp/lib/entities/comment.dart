
import 'package:travelmakerapp/entities/person.dart';
import 'package:travelmakerapp/entities/validator.dart';

class Comment {

  String text;
  Person person;


  Comment(this.text, this.person);

  Validator validateComment(Comment comment){

    if(text.isEmpty){
      return Validator(false, 'Commentary null');
    }

    return Validator(true, null);
  }


  Map<String, dynamic> toMap(int stopID) {
    return {
      'comm_text': text,
      'stop_id' : stopID,
      'person_id': person.personId,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map, Person person) {
    return Comment(
      map['comm_text'],
      person,
    );
  }

}