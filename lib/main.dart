import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'theme/theme_notifier.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const AthlosRoot());
}

// ─── Root com ThemeNotifier ───────────────────────────────────────────────────
class AthlosRoot extends StatefulWidget {
  const AthlosRoot({super.key});

  @override
  State<AthlosRoot> createState() => _AthlosRootState();

  static _AthlosRootState of(BuildContext context) =>
      context.findAncestorStateOfType<_AthlosRootState>()!;
}

class _AthlosRootState extends State<AthlosRoot> {
  final ThemeNotifier _themeNotifier = ThemeNotifier();

  @override
  void initState() {
    super.initState();
    _themeNotifier.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _themeNotifier.dispose();
    super.dispose();
  }

  ThemeNotifier get notifier => _themeNotifier;

  void updatePrimaryColor(Color color) => _themeNotifier.setPrimaryColor(color);
  void updateBackgroundColor(Color color) => _themeNotifier.setBackgroundColor(color);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Athlos',
      debugShowCheckedModeBanner: false,
      theme: _themeNotifier.buildTheme(),
      // Ponto de entrada único: Login
      home: const LoginScreen(),
    );
  }
}
