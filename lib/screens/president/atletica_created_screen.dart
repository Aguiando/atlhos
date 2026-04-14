import 'package:flutter/material.dart';
import '../../theme/theme_notifier.dart';
import '../login_screen.dart';

class AtleticaCreatedScreen extends StatefulWidget {
  final String atleticaName;
  final String presidentName;
  final Color primaryColor;

  const AtleticaCreatedScreen({
    super.key,
    required this.atleticaName,
    required this.presidentName,
    required this.primaryColor,
  });

  @override
  State<AtleticaCreatedScreen> createState() => _AtleticaCreatedScreenState();
}

class _AtleticaCreatedScreenState extends State<AtleticaCreatedScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _scaleAnim = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller,
          curve: const Interval(0.3, 1.0, curve: Curves.easeOut)),
    );
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller,
          curve: const Interval(0.3, 1.0, curve: Curves.easeOut)),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ext = context.athlos;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ext.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(28),
          child: Column(
            children: [
              const SizedBox(height: 16),

              // ── Ícone animado ───────────────────────────────────────────
              ScaleTransition(
                scale: _scaleAnim,
                child: Container(
                  width: 100, height: 100,
                  decoration: BoxDecoration(
                    color: widget.primaryColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: widget.primaryColor.withOpacity(0.35),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.check_rounded, color: Colors.white, size: 52),
                ),
              ),

              const SizedBox(height: 32),

              // ── Textos animados ─────────────────────────────────────────
              FadeTransition(
                opacity: _fadeAnim,
                child: SlideTransition(
                  position: _slideAnim,
                  child: Column(
                    children: [
                      Text(
                        'Atlética criada\ncom sucesso!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28, fontWeight: FontWeight.w800,
                          color: ext.textPrimary, height: 1.15,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.atleticaName.isNotEmpty
                            ? '"${widget.atleticaName}" está pronta para decolar.'
                            : 'Sua atlética está pronta para decolar.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15, color: ext.textSecondary, height: 1.5),
                      ),
                      const SizedBox(height: 32),

                      // ── Cards de resumo ───────────────────────────────
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: ext.surfaceColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: ext.borderColor),
                        ),
                        child: Column(children: [
                          _SummaryRow(
                            icon: Icons.sports,
                            label: 'Atlética',
                            value: widget.atleticaName.isNotEmpty
                                ? widget.atleticaName : 'Sem nome definido',
                            ext: ext,
                            color: widget.primaryColor,
                          ),
                          Divider(color: ext.borderColor, height: 20),
                          _SummaryRow(
                            icon: Icons.star_outline,
                            label: 'Presidente',
                            value: widget.presidentName.isNotEmpty
                                ? widget.presidentName : 'Sem nome definido',
                            ext: ext,
                            color: widget.primaryColor,
                          ),
                          Divider(color: ext.borderColor, height: 20),
                          _SummaryRow(
                            icon: Icons.palette_outlined,
                            label: 'Cor principal',
                            value: '#${widget.primaryColor.value.toRadixString(16).substring(2).toUpperCase()}',
                            ext: ext,
                            color: widget.primaryColor,
                            colorDot: widget.primaryColor,
                          ),
                        ]),
                      ),
                      const SizedBox(height: 24),

                      // ── Próximos passos ───────────────────────────────
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: widget.primaryColor.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: widget.primaryColor.withOpacity(0.2)),
                        ),
                        child: Column(children: [
                          _NextStep(number: '1', text: 'Faça login com seu perfil de Presidente', ext: ext, primary: widget.primaryColor),
                          const SizedBox(height: 10),
                          _NextStep(number: '2', text: 'Adicione membros pelo painel Admin', ext: ext, primary: widget.primaryColor),
                          const SizedBox(height: 10),
                          _NextStep(number: '3', text: 'Crie eventos e postagens para engajar', ext: ext, primary: widget.primaryColor),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // ── Botão ir para login ─────────────────────────────────────
              FadeTransition(
                opacity: _fadeAnim,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Volta para o login removendo todo o stack
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text(
                      'Ir para o Login',
                      style: TextStyle(
                        color: Colors.white, fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              FadeTransition(
                opacity: _fadeAnim,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                      (route) => false,
                    );
                  },
                  child: Text(
                    'Explorar como convidado',
                    style: TextStyle(
                      fontSize: 13, color: ext.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final AthlosThemeExtension ext;
  final Color color;
  final Color? colorDot;

  const _SummaryRow({
    required this.icon, required this.label, required this.value,
    required this.ext, required this.color, this.colorDot,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        width: 32, height: 32,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 16, color: color),
      ),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label,
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600,
              color: ext.textSecondary, letterSpacing: 0.5)),
        Text(value,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: ext.textPrimary)),
      ])),
      if (colorDot != null)
        Container(
          width: 20, height: 20,
          decoration: BoxDecoration(color: colorDot, shape: BoxShape.circle),
        ),
    ]);
  }
}

class _NextStep extends StatelessWidget {
  final String number;
  final String text;
  final AthlosThemeExtension ext;
  final Color primary;

  const _NextStep({
    required this.number, required this.text,
    required this.ext, required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        width: 22, height: 22,
        decoration: BoxDecoration(color: primary, shape: BoxShape.circle),
        child: Center(child: Text(number,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white))),
      ),
      const SizedBox(width: 10),
      Expanded(child: Text(text,
        style: TextStyle(fontSize: 12, color: ext.textPrimary, height: 1.3))),
    ]);
  }
}
