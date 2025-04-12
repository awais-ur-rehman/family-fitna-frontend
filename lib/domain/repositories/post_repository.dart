import '../entities/post_entity.dart';
import '../entities/pagination_entity.dart';
import 'dart:io';

abstract class PostRepository {
  Future<List<PostEntity>> getGroupPosts(String groupId, {int page = 1, int limit = 20});
  Future<PostEntity> getPostDetails(String postId);
  Future<PostEntity> createPost(String groupId, String? content, File? media);
  Future<PostEntity> updatePost(String postId, String content);
  Future<void> deletePost(String postId);
  Future<int> togglePostReaction(String postId, bool add);
}