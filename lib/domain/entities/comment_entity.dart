import 'base_entity.dart';
import 'user_entity.dart';

class CommentEntity extends BaseEntity {
  final String postId;
  final UserEntity author;
  final String? parentCommentId;
  final String? content;
  final String mediaType;
  final String? mediaUrl;
  final int reactionCount;
  final int replyCount;
  final DateTime createdAt;
  final bool hasReacted;

  const CommentEntity({
    required String id,
    required this.postId,
    required this.author,
    this.parentCommentId,
    this.content,
    required this.mediaType,
    this.mediaUrl,
    required this.reactionCount,
    required this.replyCount,
    required this.createdAt,
    required this.hasReacted,
  }) : super(id);

  @override
  List<Object?> get props => [
    id,
    postId,
    author,
    parentCommentId,
    content,
    mediaType,
    mediaUrl,
    reactionCount,
    replyCount,
    createdAt,
    hasReacted,
  ];

  factory CommentEntity.fromJson(Map<String, dynamic> json) {
    return CommentEntity(
      id: json['id'] ?? json['_id'] ?? '',
      postId: json['post']?['id'] ?? json['post'] ?? '',
      author: json['author'] is Map
          ? UserEntity.fromJson(json['author'])
          : UserEntity(
        id: '',
        email: '',
        name: '',
        isEmailVerified: false,
        createdAt: DateTime.now(),
      ),
      parentCommentId: json['parentComment'],
      content: json['content'],
      mediaType: json['mediaType'] ?? 'none',
      mediaUrl: json['mediaUrl'],
      reactionCount: json['reactionCount'] ?? 0,
      replyCount: json['replyCount'] ?? 0,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      hasReacted: json['hasReacted'] ?? false,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'post': postId,
      'author': author.toJson(),
      'parentComment': parentCommentId,
      'content': content,
      'mediaType': mediaType,
      'mediaUrl': mediaUrl,
      'reactionCount': reactionCount,
      'replyCount': replyCount,
      'createdAt': createdAt.toIso8601String(),
      'hasReacted': hasReacted,
    };
  }
}