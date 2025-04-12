import '../entities/comment_entity.dart';
import 'dart:io';

abstract class CommentRepository {
  Future<List<CommentEntity>> getPostComments(
      String postId, {
        String? parentCommentId,
        int page = 1,
        int limit = 20,
      });
  Future<CommentEntity> addComment(
      String postId,
      String? content,
      File? media,
      String? parentCommentId,
      );
  Future<CommentEntity> updateComment(String commentId, String content);
  Future<void> deleteComment(String commentId);
  Future<int> toggleCommentReaction(String commentId, bool add);
}