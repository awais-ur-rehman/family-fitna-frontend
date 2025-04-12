import '../entities/group_entity.dart';
import '../entities/leaderboard_entry_entity.dart';
import '../entities/member_profile_entity.dart';

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
  Future<List<LeaderboardEntryEntity>> getLeaderboard(String groupId);
  Future<MemberProfileEntity> getMemberProfile(String groupId, String userId);
}