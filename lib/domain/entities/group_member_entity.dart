import 'package:equatable/equatable.dart';
import 'badge_entity.dart';

class GroupMemberEntity extends Equatable {
  final String userId;
  final String? name;
  final String? profilePicture;
  final String role;
  final int points;
  final List<BadgeEntity> badges;
  final DateTime joinedAt;

  const GroupMemberEntity({
    required this.userId,
    this.name,
    this.profilePicture,
    required this.role,
    required this.points,
    required this.badges,
    required this.joinedAt,
  });

  @override
  List<Object?> get props => [
    userId,
    name,
    profilePicture,
    role,
    points,
    badges,
    joinedAt,
  ];

  factory GroupMemberEntity.fromJson(Map<String, dynamic> json) {
    return GroupMemberEntity(
      userId: json['user']?['id'] ?? json['user'] ?? '',
      name: json['user']?['name'],
      profilePicture: json['user']?['profilePicture'],
      role: json['role'] ?? 'member',
      points: json['points'] ?? 0,
      badges: (json['badges'] as List?)
          ?.map((b) => BadgeEntity.fromJson(b))
          .toList() ?? [],
      joinedAt: json['joinedAt'] != null
          ? DateTime.parse(json['joinedAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': userId,
      'role': role,
      'points': points,
      'badges': badges.map((b) => b.toJson()).toList(),
      'joinedAt': joinedAt.toIso8601String(),
    };
  }
}