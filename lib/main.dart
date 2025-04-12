import 'package:flutter/material.dart';
import 'app.dart';
import 'core/di/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  // Initialize Firebase for push notifications (we'll configure this later)
  try {
    // await Firebase.initializeApp();
  } catch (e) {
    print('Firebase initialization failed: $e');
  }

  // Initialize dependency injection
  await setupLocator();

  runApp(const FamilyFitnaApp());
}