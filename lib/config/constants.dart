class ApiConstants {
  // Base API URL - update this with your actual backend URL
  static const String baseUrl = 'http://10.0.2.2:3000'; // For Android emulator
  // static const String baseUrl = 'http://localhost:3000'; // For iOS simulator

  // API endpoints
  static const String login = '/api/auth/login';
  static const String register = '/api/auth/register';
  static const String verifyEmail = '/api/auth/verify-email/';
  static const String forgotPassword = '/api/auth/forgot-password';
  static const String resetPassword = '/api/auth/reset-password/';
  static const String logout = '/api/auth/logout';
  static const String currentUser = '/api/users/me';
  static const String updateProfile = '/api/users/me';
  static const String updateProfilePicture = '/api/users/me/profile-picture';
  static const String groups = '/api/groups';
  static const String joinGroup = '/api/groups/join';

  // Keys for secure storage
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
}

class AppConstants {
  static const String appName = 'Family Fitna';

  // Error messages
  static const String networkErrorMessage = 'Network error. Please check your connection.';
  static const String unexpectedErrorMessage = 'An unexpected error occurred. Please try again.';
  static const String authErrorMessage = 'Authentication failed. Please log in again.';

  // Storage keys
  static const String firstLaunchKey = 'first_launch';
}