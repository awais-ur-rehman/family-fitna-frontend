import 'base_entity.dart';
import 'group_member_entity.dart';

class GroupEntity extends BaseEntity {
  final String name;
  final String? description;
  final String createdById;
  final String joinCode;
  final List<GroupMemberEntity> members;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;

  const GroupEntity({
    required String id,
    required this.name,
    this.description,
    required this.createdById,
    required this.joinCode,
    required this.members,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
  }) : super(id);

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    createdById,
    joinCode,
    members,
    createdAt,
    updatedAt,
    isActive,
  ];

  factory GroupEntity.fromJson(Map<String, dynamic> json) {
    return GroupEntity(
      id: json['id'] ?? json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      createdById: json['createdBy']?['id'] ?? json['createdBy'] ?? '',
      joinCode: json['joinCode'] ?? '',
      members: (json['members'] as List?)
          ?.map((m) => GroupMemberEntity.fromJson(m))
          .toList() ?? [],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
      isActive: json['isActive'] ?? true,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'createdBy': createdById,
      'joinCode': joinCode,
      'members': members.map((m) => m.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isActive': isActive,
    };
  }
}