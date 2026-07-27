import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'features/auth/auth_gate.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ClassicalLyApp());
}

class ClassicalLyApp extends StatelessWidget {
  const ClassicalLyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'classical.ly',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        home: const AuthGate(),
      );
}
