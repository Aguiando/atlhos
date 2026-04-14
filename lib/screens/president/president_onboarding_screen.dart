import 'package:flutter/material.dart';
import '../../theme/theme_notifier.dart';
import '../../main.dart';
import 'atletica_created_screen.dart';

class PresidentOnboardingScreen extends StatefulWidget {
  const PresidentOnboardingScreen({super.key});

  @override
  State<PresidentOnboardingScreen> createState() => _PresidentOnboardingScreenState();
}

class _PresidentOnboardingScreenState extends State<PresidentOnboardingScreen> {
  // Agora só 2 steps: 0 = Criar Atlética, 1 = Personalização
  int _step = 0;
  Color _primaryColor = const Color(0xFF2563EB);
  Color _backgroundColor = const Color(0xFFF8FAFC);

  // Controladores para capturar os dados preenchidos
  final _atleticaController = TextEditingController();
  final _presidentController = TextEditingController();

  @override
  void dispose() {
    _atleticaController.dispose();
    _presidentController.dispose();
    super.dispose();
  }

  void _applyTheme() {
    final root = AthlosRoot.of(context);
    root.updatePrimaryColor(_primaryColor);
    root.updateBackgroundColor(_backgroundColor);
  }

  @override
  Widget build(BuildContext context) {
    final ext = context.athlos;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ext.backgroundColor,
      appBar: AppBar(
        backgroundColor: ext.surfaceColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ext.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(children: [
          Container(
            width: 24, height: 24,
            decoration: BoxDecoration(color: ext.primaryColor, borderRadius: BorderRadius.circular(5)),
            child: const Icon(Icons.sports, color: Colors.white, size: 13),
          ),
          const SizedBox(width: 7),
          Text('Create Atlética',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: ext.textPrimary)),
        ]),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: ext.borderColor),
        ),
      ),
      body: Column(
        children: [
          // ── Step indicator (2 steps) ──────────────────────────────────────
          Container(
            color: ext.surfaceColor,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              children: List.generate(2, (i) {
                final active = i <= _step;
                final current = i == _step;
                return Expanded(
                  child: Row(children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      width: 26, height: 26,
                      decoration: BoxDecoration(
                        color: active ? ext.primaryColor : ext.surfaceVariant,
                        shape: BoxShape.circle,
                        border: Border.all(color: current ? ext.primaryColor : ext.borderColor),
                      ),
                      child: Center(
                        child: active && !current
                            ? const Icon(Icons.check, size: 13, color: Colors.white)
                            : Text('${i + 1}',
                                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600,
                                    color: current ? Colors.white : ext.textSecondary)),
                      ),
                    ),
                    if (i < 1)
                      Expanded(child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        height: 2,
                        color: active ? ext.primaryColor : ext.borderColor,
                      )),
                  ]),
                );
              }),
            ),
          ),

          // ── Conteúdo ──────────────────────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_step == 0) ..._buildStep0(ext),
                  if (_step == 1) ..._buildStep1(ext),
                ],
              ),
            ),
          ),

          // ── Botões ────────────────────────────────────────────────────────
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ext.surfaceColor,
              border: Border(top: BorderSide(color: ext.borderColor)),
            ),
            child: Row(children: [
              if (_step > 0) ...[
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => setState(() => _step--),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: ext.primaryColor,
                      side: BorderSide(color: ext.borderColor),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Voltar'),
                  ),
                ),
                const SizedBox(width: 10),
              ],
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () {
                    if (_step == 0) {
                      setState(() => _step = 1);
                    } else {
                      // Vai para a tela de conclusão com os dados preenchidos
                      Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => AtleticaCreatedScreen(
                          atleticaName: _atleticaController.text.trim(),
                          presidentName: _presidentController.text.trim(),
                          primaryColor: _primaryColor,
                        )));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ext.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(
                    _step == 0 ? 'Próximo' : 'Finalizar Cadastro',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  // ── Step 0: Criar Atlética ─────────────────────────────────────────────────
  List<Widget> _buildStep0(AthlosThemeExtension ext) {
    return [
      Text('Crie sua\nAtlética',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700,
            color: ext.textPrimary, height: 1.2)),
      const SizedBox(height: 6),
      Text('Personalize sua organização com logo, cores e muito mais.',
        style: TextStyle(fontSize: 12, color: ext.textSecondary, height: 1.4)),
      const SizedBox(height: 20),

      // Upload logo
      Center(
        child: Container(
          width: 90, height: 90,
          decoration: BoxDecoration(
            color: ext.surfaceVariant,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: ext.borderColor),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.add_photo_alternate_outlined, size: 28, color: ext.textSecondary),
            const SizedBox(height: 4),
            Text('Adicionar\nLogo', textAlign: TextAlign.center,
              style: TextStyle(fontSize: 9, color: ext.textSecondary)),
          ]),
        ),
      ),
      const SizedBox(height: 6),
      Center(
        child: Text('Selecionar Arquivo',
          style: TextStyle(fontSize: 11, color: ext.primaryColor, fontWeight: FontWeight.w500)),
      ),
      const SizedBox(height: 20),

      _label('NOME DA ATLÉTICA', ext),
      const SizedBox(height: 6),
      _field('Ex: Pantheon Nexgen 2021', ext, controller: _atleticaController),
      const SizedBox(height: 14),

      _label('NOME DO PRESIDENTE', ext),
      const SizedBox(height: 6),
      _field('Ex: Pandora Rouge', ext, controller: _presidentController),
      const SizedBox(height: 20),

      // Preview card
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ext.primaryColor, Color.lerp(ext.primaryColor, Colors.black, 0.3)!],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Pronto para liderar?',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)),
          const SizedBox(height: 4),
          const Text(
            'Confira os dados de fundação da sua atlética antes de avançar.',
            style: TextStyle(fontSize: 10, color: Colors.white70, height: 1.4)),
          const SizedBox(height: 14),
          Row(children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white54),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ),
                child: const Text('Visualizar', style: TextStyle(fontSize: 12)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () => setState(() => _step = 1),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ),
                child: Text('Personalizar\nCores', textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600,
                      color: ext.primaryColor)),
              ),
            ),
          ]),
        ]),
      ),
    ];
  }

  // ── Step 1: Personalização de Cores ───────────────────────────────────────
  List<Widget> _buildStep1(AthlosThemeExtension ext) {
    final primaryOptions = [
      const Color(0xFF2563EB), const Color(0xFF7C3AED), const Color(0xFFDB2777),
      const Color(0xFFDC2626), const Color(0xFFEA580C), const Color(0xFF16A34A),
      const Color(0xFF0D9488), const Color(0xFF4338CA),
    ];
    final bgOptions = [
      const Color(0xFFF8FAFC), const Color(0xFFF1F5F9), const Color(0xFFFAF7F2),
      const Color(0xFFF0FDF4), const Color(0xFFEFF6FF), const Color(0xFFF5F3FF),
      const Color(0xFF0F172A), const Color(0xFF1E293B),
    ];

    return [
      Text('Personalização',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700,
            color: ext.textPrimary, height: 1.2)),
      const SizedBox(height: 6),
      Text('Escolha as cores que representam sua atlética. As mudanças são aplicadas em tempo real.',
        style: TextStyle(fontSize: 12, color: ext.textSecondary, height: 1.4)),
      const SizedBox(height: 20),

      _ColorPickerSection(
        title: 'Cor Primária',
        subtitle: 'Botões, ícones e destaques',
        icon: Icons.palette_outlined,
        colors: primaryOptions,
        selected: _primaryColor,
        onSelect: (c) { setState(() => _primaryColor = c); _applyTheme(); },
        ext: ext,
      ),
      const SizedBox(height: 14),

      _ColorPickerSection(
        title: 'Cor de Fundo',
        subtitle: 'Background geral do app',
        icon: Icons.format_paint_outlined,
        colors: bgOptions,
        selected: _backgroundColor,
        onSelect: (c) { setState(() => _backgroundColor = c); _applyTheme(); },
        ext: ext,
      ),
      const SizedBox(height: 20),

      Text('Preview ao Vivo',
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: ext.textSecondary)),
      const SizedBox(height: 10),
      _MiniPreview(primary: _primaryColor, background: _backgroundColor),
    ];
  }

  Widget _label(String text, AthlosThemeExtension ext) => Text(text,
    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700,
        color: ext.textSecondary, letterSpacing: 0.5));

  Widget _field(String hint, AthlosThemeExtension ext,
      {TextInputType? keyboard, int maxLines = 1, TextEditingController? controller}) =>
      TextField(
        controller: controller,
        keyboardType: keyboard, maxLines: maxLines,
        style: TextStyle(fontSize: 13, color: ext.textPrimary),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: ext.textSecondary.withOpacity(0.5), fontSize: 12),
          filled: true, fillColor: ext.surfaceVariant, isDense: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: ext.borderColor)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: ext.borderColor)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: ext.primaryColor, width: 1.5)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
      );
}

// ─── Color Picker Section ─────────────────────────────────────────────────────
class _ColorPickerSection extends StatelessWidget {
  final String title, subtitle;
  final IconData icon;
  final List<Color> colors;
  final Color selected;
  final ValueChanged<Color> onSelect;
  final AthlosThemeExtension ext;

  const _ColorPickerSection({
    required this.title, required this.subtitle, required this.icon,
    required this.colors, required this.selected,
    required this.onSelect, required this.ext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ext.surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ext.borderColor),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
            width: 30, height: 30,
            decoration: BoxDecoration(
              color: selected.withOpacity(0.15),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Icon(icon, size: 16, color: selected),
          ),
          const SizedBox(width: 8),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: ext.textPrimary)),
            Text(subtitle, style: TextStyle(fontSize: 10, color: ext.textSecondary)),
          ])),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 24, height: 24,
            decoration: BoxDecoration(
              color: selected, shape: BoxShape.circle,
              border: Border.all(color: ext.borderColor, width: 2),
            ),
          ),
        ]),
        const SizedBox(height: 12),
        Divider(color: ext.borderColor, height: 1),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10, runSpacing: 8,
          children: colors.map((c) {
            final sel = c.value == selected.value;
            return GestureDetector(
              onTap: () => onSelect(c),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 34, height: 34,
                decoration: BoxDecoration(
                  color: c, shape: BoxShape.circle,
                  border: sel
                      ? Border.all(color: ext.textPrimary, width: 2.5)
                      : Border.all(color: Colors.transparent),
                  boxShadow: sel
                      ? [BoxShadow(color: c.withOpacity(0.4), blurRadius: 6, offset: const Offset(0, 2))]
                      : [],
                ),
                child: sel ? const Icon(Icons.check, color: Colors.white, size: 16) : null,
              ),
            );
          }).toList(),
        ),
      ]),
    );
  }
}

// ─── Mini Preview ─────────────────────────────────────────────────────────────
class _MiniPreview extends StatelessWidget {
  final Color primary, background;
  const _MiniPreview({required this.primary, required this.background});

  @override
  Widget build(BuildContext context) {
    final isDark = background.computeLuminance() < 0.2;
    final surface = isDark ? const Color(0xFF1E293B) : Colors.white;
    final text = isDark ? Colors.white : const Color(0xFF0F172A);
    final border = isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      decoration: BoxDecoration(
        color: background, borderRadius: BorderRadius.circular(14),
        border: Border.all(color: border),
      ),
      child: Column(children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
            border: Border(bottom: BorderSide(color: border)),
          ),
          child: Row(children: [
            Container(
              width: 18, height: 18,
              decoration: BoxDecoration(color: primary, borderRadius: BorderRadius.circular(4)),
              child: const Icon(Icons.sports, color: Colors.white, size: 10),
            ),
            const SizedBox(width: 5),
            Text('ATHLOS',
              style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: text, letterSpacing: 1.5)),
            const Spacer(),
            Icon(Icons.notifications_outlined, size: 14, color: text.withOpacity(0.5)),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: surface, borderRadius: BorderRadius.circular(8),
                border: Border.all(color: border),
              ),
              child: Row(children: [
                CircleAvatar(
                  radius: 14, backgroundColor: primary.withOpacity(0.2),
                  child: Text('PA', style: TextStyle(fontSize: 8, fontWeight: FontWeight.w700, color: primary)),
                ),
                const SizedBox(width: 8),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Pedro Alves', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: text)),
                  Text('Presidente', style: TextStyle(fontSize: 8, color: text.withOpacity(0.5))),
                ])),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: primary.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
                  child: Text('Ativo',
                    style: TextStyle(fontSize: 8, fontWeight: FontWeight.w600, color: primary)),
                ),
              ]),
            ),
            const SizedBox(height: 8),
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(color: primary, borderRadius: BorderRadius.circular(7)),
              child: const Center(
                child: Text('Confirmar Presença',
                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: Colors.white)),
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}
