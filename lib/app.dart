// File: lib/app.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/routes.dart';
import 'config/theme.dart';
import 'core/di/locator.dart';

// Import the cubits
import 'presentation/blocs/auth/auth_cubit.dart';
import 'presentation/blocs/auth/register_cubit.dart';
import 'presentation/blocs/auth/otp_verification_cubit.dart';
import 'presentation/blocs/auth/forgot_password_cubit.dart';
import 'presentation/blocs/auth/reset_password_cubit.dart';
import 'presentation/blocs/navigation/navigation_cubit.dart';
import 'presentation/blocs/group/group_list_cubit.dart';
import 'presentation/blocs/group/create_group_cubit.dart';
import 'presentation/blocs/group/join_group_cubit.dart';

// Import repositories
import 'domain/repositories/auth_repository.dart';
import 'domain/repositories/group_repository.dart';

class FamilyFitnaApp extends StatelessWidget {
  const FamilyFitnaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Auth Cubits
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(locator<AuthRepository>()),
        ),
        BlocProvider<RegisterCubit>(
          create: (context) => RegisterCubit(locator<AuthRepository>()),
        ),
        BlocProvider<OtpVerificationCubit>(
          create: (context) => OtpVerificationCubit(locator<AuthRepository>()),
        ),
        BlocProvider<ForgotPasswordCubit>(
          create: (context) => ForgotPasswordCubit(locator<AuthRepository>()),
        ),
        BlocProvider<ResetPasswordCubit>(
          create: (context) => ResetPasswordCubit(locator<AuthRepository>()),
        ),

        // Navigation Cubit
        BlocProvider<NavigationCubit>(
          create: (context) => NavigationCubit(),
        ),

        // Group Cubits
        BlocProvider<GroupListCubit>(
          create: (context) => GroupListCubit(locator<GroupRepository>()),
        ),
        BlocProvider<CreateGroupCubit>(
          create: (context) => CreateGroupCubit(locator<GroupRepository>()),
        ),
        BlocProvider<JoinGroupCubit>(
          create: (context) => JoinGroupCubit(locator<GroupRepository>()),
        ),
      ],
      child: MaterialApp(
        title: 'Family Fitna',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRouter.splash,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}