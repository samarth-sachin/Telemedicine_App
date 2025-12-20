import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'storage/hive_manager.dart';
import 'storage/preferences_manager.dart';
import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize storage
  await HiveManager.initialize();
  await PreferencesManager.initialize();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const TeleMediApp());
}

class TeleMediApp extends StatelessWidget {
  const TeleMediApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
