import 'base_entity.dart';
import 'user_entity.dart';

class PostEntity extends BaseEntity {
  final String groupId;
  final UserEntity author;
  final String? content;
  final String mediaType;
  final String? mediaUrl;
  final int reactionCount;
  final int commentCount;
  final DateTime createdAt;
  final bool hasReacted;

  const PostEntity({
    required String id,
    required this.groupId,
    required this.author,
    this.content,
    required this.mediaType,
    this.mediaUrl,
    required this.reactionCount,
    required this.commentCount,
    required this.createdAt,
    required this.hasReacted,
  }) : super(id);

  @override
  List<Object?> get props => [
    id,
    groupId,
    author,
    content,
    mediaType,
    mediaUrl,
    reactionCount,
    commentCount,
    createdAt,
    hasReacted,
  ];

  factory PostEntity.fromJson(Map<String, dynamic> json) {
    return PostEntity(
      id: json['id'] ?? json['_id'] ?? '',
      groupId: json['group']?['id'] ?? json['group'] ?? '',
      author: json['author'] is Map
          ? UserEntity.fromJson(json['author'])
          : UserEntity(
        id: '',
        email: '',
        name: '',
        isEmailVerified: false,
        createdAt: DateTime.now(),
      ),
      content: json['content'],
      mediaType: json['mediaType'] ?? 'none',
      mediaUrl: json['mediaUrl'],
      reactionCount: json['reactionCount'] ?? 0,
      commentCount: json['commentCount'] ?? 0,
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
      'group': groupId,
      'author': author.toJson(),
      'content': content,
      'mediaType': mediaType,
      'mediaUrl': mediaUrl,
      'reactionCount': reactionCount,
      'commentCount': commentCount,
      'createdAt': createdAt.toIso8601String(),
      'hasReacted': hasReacted,
    };
  }
}