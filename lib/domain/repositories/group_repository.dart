// File: lib/domain/repositories/group_repository.dart

import '../entities/group_entity.dart';

abstract class GroupRepository {
  Future<List<GroupEntity>> getGroups();
  Future<GroupEntity> getGroupDetails(String groupId);
  Future<GroupEntity> createGroup(String name, String? description);
  Future<GroupEntity> joinGroup(String joinCode);
  Future<GroupEntity> updateGroup(String groupId, String name, String? description);
  Future<String> regenerateJoinCode(String groupId);
  Future<void> updateMemberRole(String groupId, String userId, String role);
  Future<void> removeMember(String groupId, String userId);
  Future<void> deleteGroup(String groupId);
}