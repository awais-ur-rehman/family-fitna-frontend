// File: lib/domain/entities/group_entity.dart

import 'package:equatable/equatable.dart';

class GroupEntity extends Equatable {
  final String id;
  final String name;
  final String? description;
  final String createdBy;
  final String? joinCode;
  final int memberCount;
  final String role;
  final DateTime createdAt;

  const GroupEntity({
    required this.id,
    required this.name,
    this.description,
    required this.createdBy,
    this.joinCode,
    required this.memberCount,
    required this.role,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    createdBy,
    joinCode,
    memberCount,
    role,
    createdAt
  ];

  factory GroupEntity.fromJson(Map<String, dynamic> json) {
    // Handle the MongoDB IDs which come as objects with $oid field
    String extractId(dynamic idField) {
      if (idField is String) return idField;
      if (idField is Map && idField.containsKey('\$oid')) return idField['\$oid'];
      return '';
    }

    // Extract createdBy which may be an object or string
    String getCreatedById(dynamic createdBy) {
      if (createdBy is String) return createdBy;
      if (createdBy is Map && createdBy.containsKey('\$oid')) return createdBy['\$oid'];
      return '';
    }

    // Parse date from MongoDB format
    DateTime parseDate(dynamic dateField) {
      if (dateField is String) return DateTime.parse(dateField);
      if (dateField is Map &&
          dateField.containsKey('\$date') &&
          dateField['\$date'] is Map &&
          dateField['\$date'].containsKey('\$numberLong')) {
        // Convert MongoDB timestamp (milliseconds) to DateTime
        final timestamp = int.parse(dateField['\$date']['\$numberLong']);
        return DateTime.fromMillisecondsSinceEpoch(timestamp);
      }
      return DateTime.now();
    }

    // Count members
    int countMembers(dynamic members) {
      if (members is List) return members.length;
      return 0;
    }

    // Find user's role in the group
    String findUserRole(dynamic members) {
      // This is a placeholder - in a real app, you'd need to check the current user ID
      // against the members list to find the actual role
      // For now, we'll assume the first member's role or default to 'member'
      if (members is List && members.isNotEmpty) {
        final firstMember = members[0];
        if (firstMember is Map && firstMember.containsKey('role')) {
          return firstMember['role'];
        }
      }
      return 'member';
    }

    // Convert _id to id if needed
    final id = json.containsKey('id') ? extractId(json['id']) :
    json.containsKey('_id') ? extractId(json['_id']) : '';

    return GroupEntity(
      id: id,
      name: json['name'] ?? '',
      description: json['description'],
      createdBy: json.containsKey('createdBy') ? getCreatedById(json['createdBy']) : '',
      joinCode: json['joinCode'],
      memberCount: json.containsKey('members') ? countMembers(json['members']) :
      json.containsKey('memberCount') ? json['memberCount'] : 0,
      role: json.containsKey('role') ? json['role'] :
      json.containsKey('members') ? findUserRole(json['members']) : 'member',
      createdAt: json.containsKey('createdAt') ? parseDate(json['createdAt']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'createdBy': createdBy,
      'joinCode': joinCode,
      'memberCount': memberCount,
      'role': role,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}