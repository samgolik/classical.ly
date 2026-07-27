import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../theme/app_theme.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});
  @override State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  bool creating = false;
  bool loading = false;
  @override void dispose() { email.dispose(); password.dispose(); super.dispose(); }

  Future<void> run(Future<void> Function() action) async {
    setState(() => loading = true);
    try { await action(); } on AuthCancelledException {} on Exception catch (error) { if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString().replaceFirst('Exception: ', '')))); } finally { if (mounted) setState(() => loading = false); }
  }

  @override
  Widget build(BuildContext context) => Scaffold(body: SafeArea(child: ListView(padding: const EdgeInsets.all(24), children: [
    const SizedBox(height: 28), Text('classical.ly', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.gold)), const SizedBox(height: 64),
    Text(creating ? 'Create your musical archive.' : 'Welcome back.', style: Theme.of(context).textTheme.displaySmall), const SizedBox(height: 12), Text(creating ? 'Your repertoire will follow you wherever you play.' : 'Your repertoire is waiting for you.', style: const TextStyle(color: AppTheme.muted, fontSize: 16)), const SizedBox(height: 34),
    TextField(controller: email, keyboardType: TextInputType.emailAddress, autocorrect: false, decoration: const InputDecoration(labelText: 'Email')), const SizedBox(height: 12), TextField(controller: password, obscureText: true, autocorrect: false, enableSuggestions: false, decoration: const InputDecoration(labelText: 'Password (6+ characters)')), const SizedBox(height: 16),
    FilledButton(onPressed: loading ? null : () => run(() async { if (creating) { await AuthService.instance.createWithEmail(email.text, password.text); } else { await AuthService.instance.signInWithEmail(email.text, password.text); } }), child: Text(creating ? 'Create account' : 'Log in')),
    TextButton(onPressed: loading ? null : () => setState(() => creating = !creating), child: Text(creating ? 'Already have an account? Log in' : 'New here? Create an account')), const SizedBox(height: 14),
    Row(children: [Expanded(child: Divider(color: AppTheme.cream.withValues(alpha: .16))), const Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text('or continue with', style: TextStyle(color: AppTheme.muted))), Expanded(child: Divider(color: AppTheme.cream.withValues(alpha: .16)))]), const SizedBox(height: 18),
    OutlinedButton.icon(onPressed: loading ? null : () => run(() async { await AuthService.instance.signInWithGoogle(); }), icon: const Icon(Icons.g_mobiledata_rounded, size: 28), label: const Text('Continue with Google')), const SizedBox(height: 10),
    OutlinedButton.icon(onPressed: loading ? null : () => run(() async { await AuthService.instance.signInWithApple(); }), icon: const Icon(Icons.apple_rounded), label: const Text('Continue with Apple')),
  ])));
}
