import 'package:sqflite/sqflite.dart';

import '../../usecase/repositories/repository_comment.dart';


/// implementation of CommentRepository
class CommentRepositoryImpl implements CommentRepository {

  /// database
  final Database db;

  ///
  CommentRepositoryImpl(this.db);

  @override
  Future<int> insertComment(int stopID, Map<String, dynamic> comment) async {

    try{
      final id = await db.insert(
        'comment',
        {
          'stop_id': stopID,
          'comm_text': comment['comm_text'],
          'person_id': comment['person_id'],
        },
      );
      return id;
    } catch (e){
      return -1;
    }




  }

  @override
  Future<int> updateComment(int commentID, Map<String, dynamic> comment) async {
    return await db.update(
      'comment',
      {
        'comm_text': comment['comm_text'],
        'stop_id': comment['stop_id'],
        'person_id': comment['person_id'],
      },
      where: 'comm_id = ',
      whereArgs: [commentID],
    );
  }

  @override
  Future<int> deleteComment(int commentID) async {
    return await db.delete(
      'comment',
      where: 'comm_id = ?',
      whereArgs: [commentID],
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getCommentsByStop(int stopID) async {
    return await db.query(
      'comment',
      where: 'stop_id = ?',
      whereArgs: [stopID],
      orderBy: 'comm_id DESC',
    );
  }
}
