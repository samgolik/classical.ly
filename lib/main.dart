import 'package:flutter/material.dart';
import 'data/profile_store.dart';
import 'features/onboarding/onboarding_flow.dart';
import 'features/onboarding/splash_screen.dart';
import 'theme/app_theme.dart';
import 'features/shell/app_shell.dart';

void main() => runApp(const ClassicalLyApp());

class ClassicalLyApp extends StatefulWidget {
  const ClassicalLyApp({super.key});
  @override State<ClassicalLyApp> createState() => _ClassicalLyAppState();
}

class _ClassicalLyAppState extends State<ClassicalLyApp> {
  late final Future<void> loadProfile = ProfileStore.instance.load();
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'classical.ly',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        home: FutureBuilder<void>(
          future: loadProfile,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) return const SplashScreen();
            return ProfileStore.instance.isComplete
                ? const AppShell()
                : OnboardingFlow(onComplete: () => setState(() {}));
          },
        ),
      );
}
