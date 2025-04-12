import 'package:flutter/material.dart';
import '../presentation/screens/auth/otp_verification_screen.dart';
import '../presentation/screens/auth/splash_screen.dart';
import '../presentation/screens/auth/onboarding_screen.dart';
import '../presentation/screens/auth/login_screen.dart';
import '../presentation/screens/auth/register_screen.dart';
import '../presentation/screens/auth/forgot_password_screen.dart';
import '../presentation/screens/auth/reset_password_screen.dart';
// We'll import the home and other screens later as we implement them
// import '../presentation/screens/home/home_screen.dart';

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
      // We'll implement this later
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Home')),
            body: const Center(child: Text('Home Screen - Coming soon')),
          ),
        );

    // For now, we'll add placeholder routes for the rest of the screens
    // We'll update these as we implement the actual screens

      case createGroup:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Create Group')),
            body: const Center(child: Text('Create Group - Coming soon')),
          ),
        );

      case joinGroup:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Join Group')),
            body: const Center(child: Text('Join Group - Coming soon')),
          ),
        );

      case groupDetails:
        final groupId = args['groupId'] as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Group Details')),
            body: Center(child: Text('Group Details for $groupId - Coming soon')),
          ),
        );

      case createPost:
        final groupId = args['groupId'] as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Create Post')),
            body: Center(child: Text('Create Post for $groupId - Coming soon')),
          ),
        );

      case postDetails:
        final postId = args['postId'] as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Post Details')),
            body: Center(child: Text('Post Details for $postId - Coming soon')),
          ),
        );

      case commentReplies:
        final commentId = args['commentId'] as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Comment Replies')),
            body: Center(child: Text('Comment Replies for $commentId - Coming soon')),
          ),
        );

      case memberProfile:
        final groupId = args['groupId'] as String? ?? '';
        final memberId = args['memberId'] as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Member Profile')),
            body: Center(child: Text('Profile for $memberId in group $groupId - Coming soon')),
          ),
        );

      case editProfile:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Edit Profile')),
            body: const Center(child: Text('Edit Profile - Coming soon')),
          ),
        );

      case groupSettings:
        final groupId = args['groupId'] as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Group Settings')),
            body: Center(child: Text('Settings for group $groupId - Coming soon')),
          ),
        );

      default:
      // If no matching route is found, show an error screen
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}