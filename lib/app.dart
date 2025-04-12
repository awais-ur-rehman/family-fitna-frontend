import 'package:flutter/material.dart';
import 'config/routes.dart';
import 'config/theme.dart';

class FamilyFitnaApp extends StatelessWidget {
  const FamilyFitnaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Family Fitna',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouter.splash,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}