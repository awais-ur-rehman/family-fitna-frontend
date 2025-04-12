import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Core
import '../network/api_client.dart';
import '../auth/auth_manager.dart';

// Services
import '../../data/services/auth_service.dart';
import '../../data/services/user_service.dart';
import '../../data/services/group_service.dart';
import '../../data/services/post_service.dart';
import '../../data/services/comment_service.dart';
import '../../data/services/notification_service.dart';

// Repositories
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/repositories/group_repository.dart';
import '../../domain/repositories/post_repository.dart';
import '../../domain/repositories/comment_repository.dart';
import '../../domain/repositories/notification_repository.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../data/repositories/group_repository_impl.dart';
import '../../data/repositories/post_repository_impl.dart';
import '../../data/repositories/comment_repository_impl.dart';
import '../../data/repositories/notification_repository_impl.dart';

import '../../config/constants.dart';

final locator = GetIt.instance;
bool _isInitialized = false;

Future<void> setupLocator() async {
  // Prevent multiple initialization
  if (_isInitialized) return;
  _isInitialized = true;

  // Core
  locator.registerLazySingleton(() => const FlutterSecureStorage());

  final dio = Dio(BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
    contentType: 'application/json',
    responseType: ResponseType.json,
  ));

  locator.registerLazySingleton(() => dio);
  locator.registerLazySingleton(() => AuthManager(locator()));
  locator.registerLazySingleton(() => ApiClient(locator(), locator()));

  // Services
  locator.registerLazySingleton(() => AuthService(locator()));
  locator.registerLazySingleton(() => UserService(locator()));
  locator.registerLazySingleton(() => GroupService(locator()));
  locator.registerLazySingleton(() => PostService(locator()));
  locator.registerLazySingleton(() => CommentService(locator()));
  locator.registerLazySingleton(() => NotificationService(locator()));

  // Repositories
  locator.registerLazySingleton<AuthRepository>(
          () => AuthRepositoryImpl(locator(), locator())
  );

  locator.registerLazySingleton<UserRepository>(
          () => UserRepositoryImpl(locator(), locator())
  );

  locator.registerLazySingleton<GroupRepository>(
          () => GroupRepositoryImpl(locator())
  );

  locator.registerLazySingleton<PostRepository>(
          () => PostRepositoryImpl(locator())
  );

  locator.registerLazySingleton<CommentRepository>(
          () => CommentRepositoryImpl(locator())
  );

  locator.registerLazySingleton<NotificationRepository>(
          () => NotificationRepositoryImpl(locator())
  );

  // Cubits - we'll register these later
}