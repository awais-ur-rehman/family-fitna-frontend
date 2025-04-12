import 'dart:io';
import '../../domain/repositories/user_repository.dart';
import '../../domain/entities/user_entity.dart';
import '../services/user_service.dart';
import '../../core/auth/auth_manager.dart';

class UserRepositoryImpl implements UserRepository {
  final UserService _userService;
  final AuthManager _authManager;

  UserRepositoryImpl(this._userService, this._authManager);

  @override
  Future<UserEntity> getCurrentUser() async {
    try {
      // First try to get from API
      final user = await _userService.getCurrentUser();

      // Update stored user
      final token = await _authManager.getToken();
      if (token != null) {
        await _authManager.saveUser(user, token);
      }

      return user;
    } catch (e) {
      // Fallback to stored user if network fails
      final user = await _authManager.getUser();
      if (user != null) {
        return user;
      }
      rethrow;
    }
  }

  @override
  Future<UserEntity> updateProfile(String name, String? bio) async {
    final updatedUser = await _userService.updateProfile(name, bio);

    // Update stored user
    final token = await _authManager.getToken();
    if (token != null) {
      await _authManager.saveUser(updatedUser, token);
    }

    return updatedUser;
  }

  @override
  Future<String> updateProfilePicture(File image) async {
    final url = await _userService.updateProfilePicture(image);

    // Update stored user with new profile pic
    final user = await _authManager.getUser();
    final token = await _authManager.getToken();

    if (user != null && token != null) {
      final updatedUser = user.copyWith(profilePicture: url);
      await _authManager.saveUser(updatedUser, token);
    }

    return url;
  }
}