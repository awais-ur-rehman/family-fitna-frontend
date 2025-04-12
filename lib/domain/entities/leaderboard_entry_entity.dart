import 'package:equatable/equatable.dart';
import 'user_entity.dart';
import 'badge_entity.dart';

class LeaderboardEntryEntity extends Equatable {
  final UserEntity user;
  final int points;
  final List<BadgeEntity> badges;
  final int rank;

  const LeaderboardEntryEntity({
    required this.user,
    required this.points,
    required this.badges,
    required this.rank,
  });

  @override
  List<Object?> get props => [user, points, badges, rank];

  factory LeaderboardEntryEntity.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntryEntity(
      user: UserEntity.fromJson(json['user'] ?? {}),
      points: json['points'] ?? 0,
      badges: (json['badges'] as List?)
          ?.map((b) => BadgeEntity.fromJson(b))
          .toList() ?? [],
      rank: json['rank'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'points': points,
      'badges': badges.map((b) => b.toJson()).toList(),
      'rank': rank,
    };
  }
}