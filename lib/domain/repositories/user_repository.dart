import '../entities/user_entity.dart';
import 'dart:io';

abstract class UserRepository {
  Future<UserEntity> getCurrentUser();
  Future<UserEntity> updateProfile(String name, String? bio);
  Future<String> updateProfilePicture(File image);
}