// File: lib/config/routes.dart

import 'package:flutter/material.dart';
import '../presentation/screens/auth/splash_screen.dart';
import '../presentation/screens/auth/onboarding_screen.dart';
import '../presentation/screens/auth/login_screen.dart';
import '../presentation/screens/auth/register_screen.dart';
import '../presentation/screens/auth/otp_verification_screen.dart';
import '../presentation/screens/auth/forgot_password_screen.dart';
import '../presentation/screens/auth/reset_password_screen.dart';
import '../presentation/screens/group/group_details_screen.dart';
import '../presentation/screens/home/home_screen.dart';
import '../presentation/screens/group/create_group_screen.dart';
import '../presentation/screens/group/join_group_screen.dart';

class AppRouter {
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
  static const String groupDetails = '/group';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Extract route arguments if available
    final args = settings.arguments as Map<String, dynamic>? ?? {};

    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case otpVerification:
        final email = args['email'] as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => OtpVerificationScreen(email: email),
        );
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case resetPassword:
        final token = args['token'] as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => ResetPasswordScreen(token: token),
        );
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case createGroup:
        return MaterialPageRoute(builder: (_) => const CreateGroupScreen());
      case joinGroup:
        return MaterialPageRoute(builder: (_) => const JoinGroupScreen());
      case groupDetails:
        final groupId = args['groupId'] as String? ?? '';
        final initialTab = args['initialTab'] as int? ?? 0;
        return MaterialPageRoute(
          builder: (_) => GroupDetailsScreen(
            groupId: groupId,
            initialTab: initialTab,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}