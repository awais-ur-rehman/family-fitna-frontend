import '../../domain/repositories/group_repository.dart';
import '../../domain/entities/group_entity.dart';
import '../../domain/entities/leaderboard_entry_entity.dart';
import '../../domain/entities/member_profile_entity.dart';
import '../services/group_service.dart';

class GroupRepositoryImpl implements GroupRepository {
  final GroupService _groupService;

  GroupRepositoryImpl(this._groupService);

  @override
  Future<List<GroupEntity>> getGroups() async {
    return await _groupService.getGroups();
  }

  @override
  Future<GroupEntity> getGroupDetails(String groupId) async {
    return await _groupService.getGroupDetails(groupId);
  }

  @override
  Future<GroupEntity> createGroup(String name, String? description) async {
    return await _groupService.createGroup(name, description);
  }

  @override
  Future<GroupEntity> joinGroup(String joinCode) async {
    return await _groupService.joinGroup(joinCode);
  }

  @override
  Future<GroupEntity> updateGroup(String groupId, String name, String? description) async {
    return await _groupService.updateGroup(groupId, name, description);
  }

  @override
  Future<String> regenerateJoinCode(String groupId) async {
    return await _groupService.regenerateJoinCode(groupId);
  }

  @override
  Future<void> updateMemberRole(String groupId, String userId, String role) async {
    await _groupService.updateMemberRole(groupId, userId, role);
  }

  @override
  Future<void> removeMember(String groupId, String userId) async {
    await _groupService.removeMember(groupId, userId);
  }

  @override
  Future<void> deleteGroup(String groupId) async {
    await _groupService.deleteGroup(groupId);
  }

  @override
  Future<List<LeaderboardEntryEntity>> getLeaderboard(String groupId) async {
    return await _groupService.getLeaderboard(groupId);
  }

  @override
  Future<MemberProfileEntity> getMemberProfile(String groupId, String userId) async {
    return await _groupService.getMemberProfile(groupId, userId);
  }
}