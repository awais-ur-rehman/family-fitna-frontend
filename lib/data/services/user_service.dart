import 'dart:io';
import 'package:dio/dio.dart';
import '../../core/network/api_client.dart';
import '../../domain/entities/user_entity.dart';
import '../../config/constants.dart';

class UserService {
  final ApiClient _apiClient;

  UserService(this._apiClient);

  Future<UserEntity> getCurrentUser() async {
    final response = await _apiClient.get(ApiConstants.currentUser);
    return UserEntity.fromJson(response['data']['user']);
  }

  Future<UserEntity> updateProfile(String name, String? bio) async {
    final data = {
      'name': name,
      if (bio != null) 'bio': bio,
    };
    final response = await _apiClient.put(ApiConstants.updateProfile, data: data);
    return UserEntity.fromJson(response['data']['user']);
  }

  Future<String> updateProfilePicture(File image) async {
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(image.path),
    });
    final response = await _apiClient.post(ApiConstants.updateProfilePicture, formData: formData);
    return response['data']['profilePicture'];
  }
}