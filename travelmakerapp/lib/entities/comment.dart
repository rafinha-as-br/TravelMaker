
import 'person.dart';
import 'validator.dart';

/// the comments that an person can add to a selected stop on the StopView
class Comment {

  /// id from database
  int? id;

  /// text
  String text;

  /// person that did the comment
  Person person;

  ///normal constructor
  Comment({required this.text, required this.person});

  /// validator
  Validator validateComment(Comment comment){

    if(text.isEmpty){
      return Validator(false, 'Commentary null');
    }

    return Validator(true, null);
  }

  /// toMap method
  Map<String, dynamic> toMap(int stopID) {
    return {
      'comm_text': text,
      'stop_id' : stopID,
      'person_id': person.personId,
    };
  }

  /// fromMap factory constructor
  factory Comment.fromMap(Map<String, dynamic> map, Person person) {
    return Comment(text: map['comm_text'], person: person)..id = map['comm_id'];
  }

}