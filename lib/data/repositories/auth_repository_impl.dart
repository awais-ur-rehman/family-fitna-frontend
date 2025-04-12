import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user_entity.dart';
import '../services/auth_service.dart';
import '../../core/auth/auth_manager.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;
  final AuthManager _authManager;

  AuthRepositoryImpl(this._authService, this._authManager);

  @override
  Future<UserEntity> login(String email, String password, String? deviceToken) async {
    final result = await _authService.login(email, password, deviceToken);
    await _authManager.saveUser(result['user'], result['token']);
    return result['user'];
  }

  @override
  Future<UserEntity> register(String name, String email, String password) async {
    final result = await _authService.register(name, email, password);
    await _authManager.saveUser(result['user'], result['token']);
    return result['user'];
  }

  @override
  Future<void> verifyEmail(String token) async {
    final newToken = await _authService.verifyEmail(token);

    // Update token in storage
    final user = await _authManager.getUser();
    if (user != null) {
      await _authManager.saveUser(user, newToken);
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    await _authService.forgotPassword(email);
  }

  @override
  Future<void> resetPassword(String token, String password) async {
    await _authService.resetPassword(token, password);
  }

  @override
  Future<void> logout() async {
    final deviceToken = await _authManager.getDeviceToken();
    await _authService.logout(deviceToken);
    await _authManager.clearUser();
  }

  @override
  Future<bool> isLoggedIn() async {
    return await _authManager.isLoggedIn();
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    return await _authManager.getUser();
  }
}