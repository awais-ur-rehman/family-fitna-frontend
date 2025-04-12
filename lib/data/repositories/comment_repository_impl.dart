import 'dart:io';
import '../../domain/repositories/comment_repository.dart';
import '../../domain/entities/comment_entity.dart';
import '../services/comment_service.dart';

class CommentRepositoryImpl implements CommentRepository {
  final CommentService _commentService;

  CommentRepositoryImpl(this._commentService);

  @override
  Future<List<CommentEntity>> getPostComments(
      String postId, {
        String? parentCommentId,
        int page = 1,
        int limit = 20,
      }) async {
    return await _commentService.getPostComments(
      postId,
      parentCommentId: parentCommentId,
      page: page,
      limit: limit,
    );
  }

  @override
  Future<CommentEntity> addComment(
      String postId,
      String? content,
      File? media,
      String? parentCommentId,
      ) async {
    return await _commentService.addComment(
      postId,
      content,
      media,
      parentCommentId,
    );
  }

  @override
  Future<CommentEntity> updateComment(String commentId, String content) async {
    return await _commentService.updateComment(commentId, content);
  }

  @override
  Future<void> deleteComment(String commentId) async {
    await _commentService.deleteComment(commentId);
  }

  @override
  Future<int> toggleCommentReaction(String commentId, bool add) async {
    return await _commentService.toggleCommentReaction(commentId, add);
  }
}