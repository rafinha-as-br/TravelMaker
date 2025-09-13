
/// contract repository for comment storage in database
abstract class CommentRepository{

  /// to insert a comment
  Future<int> insertComment(int stopID, Map<String, dynamic> comment);

  /// to update a comment
  Future<int> updateComment(int commentID, Map<String, dynamic> comment);

  /// to delete a comment
  Future<int> deleteComment(int commentID);

  /// to get a list of comments by stopID
  Future<List<Map<String, dynamic>>> getCommentsByStop(int stopID);



}