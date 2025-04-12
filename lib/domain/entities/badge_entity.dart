import 'base_entity.dart';

class BadgeEntity extends BaseEntity {
  final String name;
  final String? description;
  final String? imageUrl;
  final int pointsRequired;
  final DateTime? earnedAt;

  const BadgeEntity({
    required String id,
    required this.name,
    this.description,
    this.imageUrl,
    required this.pointsRequired,
    this.earnedAt,
  }) : super(id);

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    imageUrl,
    pointsRequired,
    earnedAt,
  ];

  factory BadgeEntity.fromJson(Map<String, dynamic> json) {
    return BadgeEntity(
      id: json['id'] ?? json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      imageUrl: json['imageUrl'],
      pointsRequired: json['pointsRequired'] ?? 0,
      earnedAt: json['earnedAt'] != null
          ? DateTime.parse(json['earnedAt'])
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'pointsRequired': pointsRequired,
      'earnedAt': earnedAt?.toIso8601String(),
    };
  }
}