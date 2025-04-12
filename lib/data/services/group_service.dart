import '../../core/network/api_client.dart';
import '../../domain/entities/group_entity.dart';
import '../../domain/entities/leaderboard_entry_entity.dart';
import '../../domain/entities/member_profile_entity.dart';
import '../../config/constants.dart';

class GroupService {
  final ApiClient _apiClient;

  GroupService(this._apiClient);

  Future<List<GroupEntity>> getGroups() async {
    final response = await _apiClient.get(ApiConstants.groups);
    return (response['data']['groups'] as List)
        .map((group) => GroupEntity.fromJson(group))
        .toList();
  }

  Future<GroupEntity> getGroupDetails(String groupId) async {
    final response = await _apiClient.get('${ApiConstants.groups}/$groupId');
    return GroupEntity.fromJson(response['data']['group']);
  }

  Future<GroupEntity> createGroup(String name, String? description) async {
    final data = {
      'name': name,
      if (description != null) 'description': description,
    };
    final response = await _apiClient.post(ApiConstants.groups, data: data);
    return GroupEntity.fromJson(response['data']['group']);
  }

  Future<GroupEntity> joinGroup(String joinCode) async {
    final response = await _apiClient.post(ApiConstants.joinGroup, data: {'joinCode': joinCode});
    return GroupEntity.fromJson(response['data']['group']);
  }

  Future<GroupEntity> updateGroup(String groupId, String name, String? description) async {
    final data = {
      'name': name,
      if (description != null) 'description': description,
    };
    final response = await _apiClient.put('${ApiConstants.groups}/$groupId', data: data);
    return GroupEntity.fromJson(response['data']['group']);
  }

  Future<String> regenerateJoinCode(String groupId) async {
    final response = await _apiClient.post('${ApiConstants.groups}/$groupId/regenerate-code');
    return response['data']['joinCode'];
  }

  Future<void> updateMemberRole(String groupId, String userId, String role) async {
    await _apiClient.put('${ApiConstants.groups}/$groupId/members/$userId/role', data: {'role': role});
  }

  Future<void> removeMember(String groupId, String userId) async {
    await _apiClient.delete('${ApiConstants.groups}/$groupId/members/$userId');
  }

  Future<void> deleteGroup(String groupId) async {
    await _apiClient.delete('${ApiConstants.groups}/$groupId');
  }

  Future<List<LeaderboardEntryEntity>> getLeaderboard(String groupId) async {
    final response = await _apiClient.get('${ApiConstants.groups}/$groupId/leaderboard');
    return (response['data']['leaderboard'] as List)
        .map((entry) => LeaderboardEntryEntity.fromJson(entry))
        .toList();
  }

  Future<MemberProfileEntity> getMemberProfile(String groupId, String userId) async {
    final response = await _apiClient.get('${ApiConstants.groups}/$groupId/members/$userId/profile');
    return MemberProfileEntity.fromJson(response['data']['profile']);
  }
}