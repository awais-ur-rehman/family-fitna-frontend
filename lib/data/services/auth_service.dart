import 'package:dio/dio.dart';
import '../../core/network/api_client.dart';
import '../../domain/entities/user_entity.dart';
import '../../config/constants.dart';

class AuthService {
  final ApiClient _apiClient;

  AuthService(this._apiClient);

  Future<Map<String, dynamic>> login(String email, String password, String? deviceToken) async {
    final data = {
      'email': email,
      'password': password,
      if (deviceToken != null) 'deviceToken': deviceToken,
    };
    final response = await _apiClient.post(ApiConstants.login, data: data);
    return {
      'user': UserEntity.fromJson(response['data']['user']),
      'token': response['data']['token'],
    };
  }

  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    final data = {
      'name': name,
      'email': email,
      'password': password,
    };
    final response = await _apiClient.post(ApiConstants.register, data: data);
    return {
      'user': UserEntity.fromJson(response['data']['user']),
      'token': response['data']['token'],
    };
  }

  Future<String> verifyEmail(String token) async {
    final response = await _apiClient.get('${ApiConstants.verifyEmail}$token');
    return response['data']['token'];
  }

  Future<void> forgotPassword(String email) async {
    await _apiClient.post(ApiConstants.forgotPassword, data: {'email': email});
  }

  Future<void> resetPassword(String token, String password) async {
    await _apiClient.post('${ApiConstants.resetPassword}$token', data: {'password': password});
  }

  Future<void> logout(String? deviceToken) async {
    await _apiClient.post(ApiConstants.logout, data: {'deviceToken': deviceToken});
  }
}