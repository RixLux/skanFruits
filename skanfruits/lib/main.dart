import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skanfruits/core/config/app_config.dart';
import 'package:skanfruits/core/config/app_theme.dart';
import 'package:skanfruits/presentation/scanner/scanner_screen.dart';

void main() {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    const ProviderScope(
      child: SkanFruitApp(),
    ),
  );
}

class SkanFruitApp extends StatelessWidget {
  const SkanFruitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const ScannerScreen(),
    );
  }
}
