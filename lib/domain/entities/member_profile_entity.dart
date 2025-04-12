import 'package:equatable/equatable.dart';
import 'user_entity.dart';
import 'badge_entity.dart';
import 'post_entity.dart';

class GroupStats extends Equatable {
  final int points;
  final int postCount;
  final int commentCount;
  final DateTime joinedAt;

  const GroupStats({
    required this.points,
    required this.postCount,
    required this.commentCount,
    required this.joinedAt,
  });

  @override
  List<Object?> get props => [points, postCount, commentCount, joinedAt];

  factory GroupStats.fromJson(Map<String, dynamic> json) {
    return GroupStats(
      points: json['points'] ?? 0,
      postCount: json['postCount'] ?? 0,
      commentCount: json['commentCount'] ?? 0,
      joinedAt: json['joinedAt'] != null
          ? DateTime.parse(json['joinedAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'points': points,
      'postCount': postCount,
      'commentCount': commentCount,
      'joinedAt': joinedAt.toIso8601String(),
    };
  }
}

class MemberProfileEntity extends Equatable {
  final UserEntity user;
  final GroupStats groupStats;
  final List<BadgeEntity> badges;
  final List<PostEntity> recentPosts;

  const MemberProfileEntity({
    required this.user,
    required this.groupStats,
    required this.badges,
    required this.recentPosts,
  });

  @override
  List<Object?> get props => [user, groupStats, badges, recentPosts];

  factory MemberProfileEntity.fromJson(Map<String, dynamic> json) {
    return MemberProfileEntity(
      user: UserEntity.fromJson(json['user'] ?? {}),
      groupStats: GroupStats.fromJson(json['groupStats'] ?? {}),
      badges: (json['badges'] as List?)
          ?.map((b) => BadgeEntity.fromJson(b))
          .toList() ?? [],
      recentPosts: (json['recentPosts'] as List?)
          ?.map((p) => PostEntity.fromJson(p))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'groupStats': groupStats.toJson(),
      'badges': badges.map((b) => b.toJson()).toList(),
      'recentPosts': recentPosts.map((p) => p.toJson()).toList(),
    };
  }
}