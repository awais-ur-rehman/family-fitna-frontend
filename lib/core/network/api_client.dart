import 'package:dio/dio.dart';
import '../error/api_exception.dart';
import '../auth/auth_manager.dart';
import '../../config/constants.dart';

class ApiClient {
  final Dio _dio;
  final AuthManager _authManager;

  ApiClient(this._dio, this._authManager) {
    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add authentication token to requests
          final token = await _authManager.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          // Handle 401 Unauthorized errors
          if (error.response?.statusCode == 401) {
            await _authManager.logout();
            // Navigate to login screen - we'll implement this later
          }
          return handler.next(error);
        },
      ),
    );
  }

  // Generic request methods
  Future<dynamic> get(String path, {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParams);
      return response.data;
    } catch (e) {
      _handleError(e);
    }
  }

  Future<dynamic> post(String path, {dynamic data, FormData? formData}) async {
    try {
      final response = await _dio.post(path, data: data ?? formData);
      return response.data;
    } catch (e) {
      _handleError(e);
    }
  }

  Future<dynamic> put(String path, {dynamic data}) async {
    try {
      final response = await _dio.put(path, data: data);
      return response.data;
    } catch (e) {
      _handleError(e);
    }
  }

  Future<dynamic> delete(String path) async {
    try {
      final response = await _dio.delete(path);
      return response.data;
    } catch (e) {
      _handleError(e);
    }
  }

  void _handleError(dynamic error) {
    if (error is DioException) {
      final errorData = error.response?.data;
      final errorMessage = errorData?['error']?['message'] ?? 'An error occurred';
      throw ApiException(errorMessage, error.response?.statusCode);
    } else {
      throw ApiException('Network error', null);
    }
  }
}