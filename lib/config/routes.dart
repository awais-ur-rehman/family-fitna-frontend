import 'package:flutter/material.dart';
import '../presentation/screens/auth/splash_screen.dart';

class AppRouter {
  // Define route names
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String otpVerification = '/otp-verification';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String home = '/home';
  static const String createGroup = '/create-group';
  static const String joinGroup = '/join-group';
  static const String groupDetails = '/group/:groupId';
  static const String createPost = '/group/:groupId/create-post';
  static const String postDetails = '/post/:postId';
  static const String commentReplies = '/comment/:commentId/replies';
  static const String memberProfile = '/group/:groupId/member/:memberId';
  static const String editProfile = '/profile/edit';
  static const String groupSettings = '/group/:groupId/settings';

  // We'll implement this fully in later phases
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // For now just return a placeholder splash screen
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text('Route: ${settings.name}'),
        ),
      ),
    );
  }
}