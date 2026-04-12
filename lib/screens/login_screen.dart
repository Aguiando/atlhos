import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/theme_notifier.dart';
import 'user/user_main_screen.dart';
import 'president/president_onboarding_screen.dart';
import 'admin/admin_shell_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final ext = context.athlos;

    return Scaffold(
      backgroundColor: ext.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo
              Row(
                children: [
                  Container(
                    width: 36, height: 36,
                    decoration: BoxDecoration(
                      color: ext.primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.sports, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 10),
                  Text('ATHLOS',
                    style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w900,
                      color: ext.textPrimary, letterSpacing: 2.5,
                    )),
                ],
              ),
              const SizedBox(height: 48),

              Text('Bem-vindo!',
                style: TextStyle(
                  fontSize: 28, fontWeight: FontWeight.w800,
                  color: ext.textPrimary, height: 1.15,
                )),
              const SizedBox(height: 8),
              Text('A plataforma definitiva para gestão e performance de atléticas universitárias.',
                style: TextStyle(fontSize: 13, color: ext.textSecondary, height: 1.5)),
              const SizedBox(height: 36),

              // Email
              _label('E-mail', ext),
              const SizedBox(height: 6),
              _textField(hint: 'seu@email.com', ext: ext, keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 16),

              // Senha
              _label('Senha', ext),
              const SizedBox(height: 6),
              TextField(
                obscureText: _obscure,
                style: TextStyle(fontSize: 14, color: ext.textPrimary),
                decoration: InputDecoration(
                  hintText: '••••••••',
                  hintStyle: TextStyle(color: ext.textSecondary.withOpacity(0.5)),
                  filled: true,
                  fillColor: ext.surfaceVariant,
                  suffixIcon: IconButton(
                    icon: Icon(_obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      size: 18, color: ext.textSecondary),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: ext.borderColor)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: ext.borderColor)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: ext.primaryColor, width: 1.5)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: Text('Esqueceu a senha?',
                  style: TextStyle(fontSize: 12, color: ext.primaryColor, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(height: 28),

              // Botão entrar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _showRoleSelector(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ext.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('ENTRAR', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 0.8)),
                ),
              ),

              const SizedBox(height: 32),
              Divider(color: ext.borderColor),
              const SizedBox(height: 24),

              // Criar atlética
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: ext.primaryColor.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: ext.primaryColor.withOpacity(0.2)),
                ),
                child: Column(
                  children: [
                    Text('Ainda não tem uma atlética?',
                      style: TextStyle(fontSize: 13, color: ext.textPrimary, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const PresidentOnboardingScreen())),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: ext.primaryColor,
                          side: BorderSide(color: ext.primaryColor),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('CRIAR SUA PRÓPRIA ATLÉTICA', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRoleSelector(BuildContext context) {
    final ext = context.athlos;
    showModalBottomSheet(
      context: context,
      backgroundColor: ext.surfaceColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(width: 36, height: 4, decoration: BoxDecoration(color: ext.borderColor, borderRadius: BorderRadius.circular(2))),
            ),
            const SizedBox(height: 20),
            Text('Entrar como', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: ext.textPrimary)),
            const SizedBox(height: 6),
            Text('Selecione seu perfil de acesso', style: TextStyle(fontSize: 13, color: ext.textSecondary)),
            const SizedBox(height: 20),
            _RoleTile(
              icon: Icons.person_outline,
              title: 'Usuário Comum',
              subtitle: 'Feed, loja, agenda e perfil',
              color: const Color(0xFF10B981),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const UserMainScreen()));
              },
            ),
            const SizedBox(height: 10),
            _RoleTile(
              icon: Icons.star_outline,
              title: 'Presidente',
              subtitle: 'Criar e gerenciar atlética',
              color: ext.primaryColor,
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const PresidentOnboardingScreen()));
              },
            ),
            const SizedBox(height: 10),
            _RoleTile(
              icon: Icons.admin_panel_settings_outlined,
              title: 'Administrador',
              subtitle: 'Painel completo de gestão',
              color: const Color(0xFFF59E0B),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AdminShellScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text, AthlosThemeExtension ext) =>
    Text(text, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: ext.textSecondary));

  Widget _textField({required String hint, required AthlosThemeExtension ext, TextInputType? keyboardType}) =>
    TextField(
      keyboardType: keyboardType,
      style: TextStyle(fontSize: 14, color: ext.textPrimary),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: ext.textSecondary.withOpacity(0.5)),
        filled: true, fillColor: ext.surfaceVariant,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: ext.borderColor)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: ext.borderColor)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: ext.primaryColor, width: 1.5)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
    );
}

class _RoleTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;
  const _RoleTile({required this.icon, required this.title, required this.subtitle, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final ext = context.athlos;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.06),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: ext.textPrimary)),
              Text(subtitle, style: TextStyle(fontSize: 12, color: ext.textSecondary)),
            ])),
            Icon(Icons.arrow_forward_ios, size: 14, color: color),
          ],
        ),
      ),
    );
  }
}
