import 'dart:io';
import 'package:dio/dio.dart';
import '../../core/network/api_client.dart';
import '../../domain/entities/comment_entity.dart';

class CommentService {
  final ApiClient _apiClient;

  CommentService(this._apiClient);

  Future<List<CommentEntity>> getPostComments(
      String postId, {
        String? parentCommentId,
        int page = 1,
        int limit = 20,
      }) async {
    final queryParams = {
      'page': page,
      'limit': limit,
      if (parentCommentId != null) 'parentCommentId': parentCommentId,
    };
    final response = await _apiClient.get(
      '/api/posts/$postId/comments',
      queryParams: queryParams,
    );
    return (response['data']['comments'] as List)
        .map((comment) => CommentEntity.fromJson(comment))
        .toList();
  }

  Future<CommentEntity> addComment(
      String postId,
      String? content,
      File? media,
      String? parentCommentId,
      ) async {
    final formData = FormData.fromMap({
      if (content != null && content.isNotEmpty) 'content': content,
      if (media != null) 'media': await MultipartFile.fromFile(media.path),
      if (parentCommentId != null) 'parentCommentId': parentCommentId,
    });
    final response = await _apiClient.post('/api/posts/$postId/comments', formData: formData);
    return CommentEntity.fromJson(response['data']['comment']);
  }

  Future<CommentEntity> updateComment(String commentId, String content) async {
    final response = await _apiClient.put('/api/comments/$commentId', data: {'content': content});
    return CommentEntity.fromJson(response['data']['comment']);
  }

  Future<void> deleteComment(String commentId) async {
    await _apiClient.delete('/api/comments/$commentId');
  }

  Future<int> toggleCommentReaction(String commentId, bool add) async {
    if (add) {
      final response = await _apiClient.post('/api/comments/$commentId/reactions');
      return response['data']['reactionCount'];
    } else {
      final response = await _apiClient.delete('/api/comments/$commentId/reactions');
      return response['data']['reactionCount'];
    }
  }
}