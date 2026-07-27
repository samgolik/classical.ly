import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.music_note_rounded, color: AppTheme.gold, size: 38), SizedBox(height: 12), Text('classical.ly', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: AppTheme.cream))])));
}
