import 'dart:io';
import '../../domain/repositories/post_repository.dart';
import '../../domain/entities/post_entity.dart';
import '../services/post_service.dart';

class PostRepositoryImpl implements PostRepository {
  final PostService _postService;

  PostRepositoryImpl(this._postService);

  @override
  Future<List<PostEntity>> getGroupPosts(String groupId, {int page = 1, int limit = 20}) async {
    return await _postService.getGroupPosts(groupId, page: page, limit: limit);
  }

  @override
  Future<PostEntity> getPostDetails(String postId) async {
    return await _postService.getPostDetails(postId);
  }

  @override
  Future<PostEntity> createPost(String groupId, String? content, File? media) async {
    return await _postService.createPost(groupId, content, media);
  }

  @override
  Future<PostEntity> updatePost(String postId, String content) async {
    return await _postService.updatePost(postId, content);
  }

  @override
  Future<void> deletePost(String postId) async {
    await _postService.deletePost(postId);
  }

  @override
  Future<int> togglePostReaction(String postId, bool add) async {
    return await _postService.togglePostReaction(postId, add);
  }
}