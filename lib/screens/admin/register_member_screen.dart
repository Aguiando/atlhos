import 'package:flutter/material.dart';
import '../../theme/theme_notifier.dart';

class RegisterMemberScreen extends StatefulWidget {
  const RegisterMemberScreen({super.key});

  @override
  State<RegisterMemberScreen> createState() => _RegisterMemberScreenState();
}

class _RegisterMemberScreenState extends State<RegisterMemberScreen> {
  String _selectedRole = 'Membro';

  @override
  Widget build(BuildContext context) {
    final ext = context.athlos;
    final roles = ['Diretor', 'Membro', 'Coordenador'];

    return Scaffold(
      backgroundColor: ext.backgroundColor,
      appBar: AppBar(
        backgroundColor: ext.surfaceColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ext.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Cadastrar Membro',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: ext.textPrimary)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: ext.borderColor),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Cadastrar\nMembro',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700,
                        color: ext.textPrimary, height: 1.2)),
                  const SizedBox(height: 6),
                  Text('Adicione novos talentos à associação atlética e defina seus papéis na organização.',
                    style: TextStyle(fontSize: 12, color: ext.textSecondary, height: 1.4)),
                  const SizedBox(height: 20),

                  // ── Informações Gerais ────────────────────────────────────
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: ext.surfaceColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: ext.borderColor),
                    ),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(children: [
                        Icon(Icons.person_outline, size: 16, color: ext.primaryColor),
                        const SizedBox(width: 6),
                        Text('Informações Gerais',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: ext.textPrimary)),
                      ]),
                      const SizedBox(height: 14),
                      _label('NOME COMPLETO', ext),
                      const SizedBox(height: 6),
                      _field('Ex: Lucas Silva de Oliveira', ext),
                      const SizedBox(height: 12),
                      _label('EMAIL', ext),
                      const SizedBox(height: 6),
                      _field('lucas@email.com', ext, keyboard: TextInputType.emailAddress),
                      const SizedBox(height: 12),
                      Row(children: [
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          _label('RA', ext),
                          const SizedBox(height: 6),
                          _field('000000', ext, keyboard: TextInputType.number),
                        ])),
                        const SizedBox(width: 12),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          _label('CURSO', ext),
                          const SizedBox(height: 6),
                          _field('Ex: Engenharia', ext),
                        ])),
                      ]),
                      const SizedBox(height: 12),
                      _label('OBSERVAÇÕES', ext),
                      const SizedBox(height: 6),
                      _field('Informações adicionais...', ext, maxLines: 2),
                    ]),
                  ),
                  const SizedBox(height: 14),

                  // ── Definição de Papel ────────────────────────────────────
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: ext.surfaceColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: ext.borderColor),
                    ),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(children: [
                        Icon(Icons.badge_outlined, size: 16, color: ext.primaryColor),
                        const SizedBox(width: 6),
                        Text('Definição de Papel',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: ext.textPrimary)),
                      ]),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: roles.map((r) {
                          final sel = r == _selectedRole;
                          return GestureDetector(
                            onTap: () => setState(() => _selectedRole = r),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 80, height: 72,
                              decoration: BoxDecoration(
                                color: sel ? ext.primaryColor : ext.surfaceVariant,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: sel ? ext.primaryColor : ext.borderColor),
                              ),
                              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                Icon(Icons.person, size: 24,
                                    color: sel ? Colors.white : ext.textSecondary),
                                const SizedBox(height: 4),
                                Text(r,
                                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600,
                                      color: sel ? Colors.white : ext.textSecondary)),
                              ]),
                            ),
                          );
                        }).toList(),
                      ),
                    ]),
                  ),
                  const SizedBox(height: 14),

                  // ── Dica do sistema ───────────────────────────────────────
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: ext.primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(children: [
                      const Icon(Icons.lightbulb_outline, color: Colors.white70, size: 18),
                      const SizedBox(width: 10),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        const Text('Dica do Sistema',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white)),
                        const SizedBox(height: 3),
                        const Text(
                          'Este membro terá acesso à atlética de acordo com as permissões do papel selecionado.',
                          style: TextStyle(fontSize: 11, color: Colors.white70, height: 1.4)),
                      ])),
                    ]),
                  ),
                  const SizedBox(height: 14),

                  // ── Estatísticas ──────────────────────────────────────────
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: ext.surfaceColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: ext.borderColor),
                    ),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Associação Atual',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: ext.textPrimary)),
                      const SizedBox(height: 12),
                      _statRow('Total de Membros', '104', ext),
                      _statRow('Vagos', '36', ext),
                      _statRow('Novos este mês', '+12', ext, color: const Color(0xFF10B981)),
                    ]),
                  ),
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
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: ext.primaryColor,
                    side: BorderSide(color: ext.borderColor),
                    padding: const EdgeInsets.symmetric(vertical: 13),
                  ),
                  child: const Text('Cancelar'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.person_add, size: 16, color: Colors.white),
                  label: const Text('Registrar →',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ext.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 13),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _label(String text, AthlosThemeExtension ext) => Text(text,
    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700,
        color: ext.textSecondary, letterSpacing: 0.5));

  Widget _field(String hint, AthlosThemeExtension ext,
      {TextInputType? keyboard, int maxLines = 1}) =>
      TextField(
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

  Widget _statRow(String label, String value, AthlosThemeExtension ext, {Color? color}) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(children: [
          Text(label, style: TextStyle(fontSize: 12, color: ext.textSecondary)),
          const Spacer(),
          Text(value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600,
              color: color ?? ext.textPrimary)),
        ]),
      );
}
