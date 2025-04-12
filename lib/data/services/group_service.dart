// File: lib/data/services/group_service.dart

import '../../core/network/api_client.dart';
import '../../domain/entities/group_entity.dart';

class GroupService {
  final ApiClient _apiClient;

  GroupService(this._apiClient);

  Future<List<GroupEntity>> getGroups() async {
    final response = await _apiClient.get('/api/groups');

    // Safely extract the groups array
    final groupsData = response['data']?['groups'] ?? [];
    if (groupsData is List) {
      return groupsData.map((group) => GroupEntity.fromJson(group)).toList();
    }
    return [];
  }

  Future<GroupEntity> getGroupDetails(String groupId) async {
    final response = await _apiClient.get('/api/groups/$groupId');
    return GroupEntity.fromJson(response['data']?['group'] ?? {});
  }

  Future<GroupEntity> createGroup(String name, String? description) async {
    final data = {
      'name': name,
      if (description != null) 'description': description,
    };
    final response = await _apiClient.post('/api/groups', data: data);
    return GroupEntity.fromJson(response['data']?['group'] ?? {});
  }

  Future<GroupEntity> joinGroup(String joinCode) async {
    final response = await _apiClient.post('/api/groups/join', data: {'joinCode': joinCode});
    return GroupEntity.fromJson(response['data']?['group'] ?? {});
  }

  Future<GroupEntity> updateGroup(String groupId, String name, String? description) async {
    final data = {
      'name': name,
      if (description != null) 'description': description,
    };
    final response = await _apiClient.put('/api/groups/$groupId', data: data);
    return GroupEntity.fromJson(response['data']?['group'] ?? {});
  }

  Future<String> regenerateJoinCode(String groupId) async {
    final response = await _apiClient.post('/api/groups/$groupId/regenerate-code');
    return response['data']?['joinCode'] ?? '';
  }

  Future<void> updateMemberRole(String groupId, String userId, String role) async {
    await _apiClient.put('/api/groups/$groupId/members/$userId/role', data: {'role': role});
  }

  Future<void> removeMember(String groupId, String userId) async {
    await _apiClient.delete('/api/groups/$groupId/members/$userId');
  }

  Future<void> deleteGroup(String groupId) async {
    await _apiClient.delete('/api/groups/$groupId');
  }
}