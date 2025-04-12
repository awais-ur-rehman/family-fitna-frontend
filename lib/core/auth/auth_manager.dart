import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../config/constants.dart';
import '../../domain/entities/user_entity.dart';

class AuthManager {
  final FlutterSecureStorage _secureStorage;

  AuthManager(this._secureStorage);

  // Save user data and token
  Future<void> saveUser(UserEntity user, String token) async {
    await _secureStorage.write(key: ApiConstants.tokenKey, value: token);
    await _secureStorage.write(
      key: ApiConstants.userKey,
      value: json.encode(user.toJson()),
    );
  }

  // Get saved token
  Future<String?> getToken() async {
    return await _secureStorage.read(key: ApiConstants.tokenKey);
  }

  // Get saved user
  Future<UserEntity?> getUser() async {
    final userJson = await _secureStorage.read(key: ApiConstants.userKey);
    if (userJson != null) {
      return UserEntity.fromJson(json.decode(userJson));
    }
    return null;
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }

  // Get device token for push notifications
  Future<String?> getDeviceToken() async {
    // We'll implement this with Firebase Messaging later
    return null;
  }

  // Clear user data on logout
  Future<void> clearUser() async {
    await _secureStorage.delete(key: ApiConstants.tokenKey);
    await _secureStorage.delete(key: ApiConstants.userKey);
  }

  // Log user out
  Future<void> logout() async {
    await clearUser();
  }
}