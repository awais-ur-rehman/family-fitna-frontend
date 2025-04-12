import 'dart:io';
import 'package:dio/dio.dart';
import '../../core/network/api_client.dart';
import '../../domain/entities/post_entity.dart';

class PostService {
  final ApiClient _apiClient;

  PostService(this._apiClient);

  Future<List<PostEntity>> getGroupPosts(String groupId, {int page = 1, int limit = 20}) async {
    final response = await _apiClient.get(
      '/api/groups/$groupId/posts',
      queryParams: {'page': page, 'limit': limit},
    );
    return (response['data']['posts'] as List)
        .map((post) => PostEntity.fromJson(post))
        .toList();
  }

  Future<PostEntity> getPostDetails(String postId) async {
    final response = await _apiClient.get('/api/posts/$postId');
    return PostEntity.fromJson(response['data']['post']);
  }

  Future<PostEntity> createPost(String groupId, String? content, File? media) async {
    final formData = FormData.fromMap({
      if (content != null && content.isNotEmpty) 'content': content,
      if (media != null) 'media': await MultipartFile.fromFile(media.path),
    });
    final response = await _apiClient.post('/api/groups/$groupId/posts', formData: formData);
    return PostEntity.fromJson(response['data']['post']);
  }

  Future<PostEntity> updatePost(String postId, String content) async {
    final response = await _apiClient.put('/api/posts/$postId', data: {'content': content});
    return PostEntity.fromJson(response['data']['post']);
  }

  Future<void> deletePost(String postId) async {
    await _apiClient.delete('/api/posts/$postId');
  }

  Future<int> togglePostReaction(String postId, bool add) async {
    if (add) {
      final response = await _apiClient.post('/api/posts/$postId/reactions');
      return response['data']['reactionCount'];
    } else {
      final response = await _apiClient.delete('/api/posts/$postId/reactions');
      return response['data']['reactionCount'];
    }
  }
}