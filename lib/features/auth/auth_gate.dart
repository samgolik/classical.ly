import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../data/profile_store.dart';
import '../../services/auth_service.dart';
import '../onboarding/onboarding_flow.dart';
import '../onboarding/splash_screen.dart';
import '../shell/app_shell.dart';
import 'auth_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});
  @override
  Widget build(BuildContext context) => StreamBuilder<User?>(
        stream: AuthService.instance.changes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const SplashScreen();
          final user = snapshot.data;
          return user == null ? const AuthPage() : _ProfileGate(user: user);
        },
      );
}

class _ProfileGate extends StatefulWidget { const _ProfileGate({required this.user}); final User user; @override State<_ProfileGate> createState() => _ProfileGateState(); }
class _ProfileGateState extends State<_ProfileGate> {
  late Future<void> loadProfile;
  @override void initState() { super.initState(); loadProfile = ProfileStore.instance.loadForUser(widget.user.uid); }
  @override Widget build(BuildContext context) => FutureBuilder<void>(future: loadProfile, builder: (context, snapshot) {
    if (snapshot.connectionState != ConnectionState.done) return const SplashScreen();
    return ProfileStore.instance.isComplete ? const AppShell() : OnboardingFlow(userId: widget.user.uid, initialName: widget.user.displayName ?? '', onComplete: () => setState(() {}));
  });
}
