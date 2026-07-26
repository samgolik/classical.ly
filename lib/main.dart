import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'features/shell/app_shell.dart';

void main() => runApp(const ClassicalLyApp());

class ClassicalLyApp extends StatelessWidget {
  const ClassicalLyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'classical.ly',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        home: const AppShell(),
      );
}
