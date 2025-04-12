import 'package:flutter/material.dart';
import 'app.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase for push notifications (we'll configure this later)
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print('Firebase initialization failed: $e');
  }

  // Initialize dependency injection (we'll implement this later)
  await setupLocator();

  runApp(const FamilyFitnaApp());
}

// We'll implement this in the next phase
Future<void> setupLocator() async {
  // This will be used for dependency injection
}