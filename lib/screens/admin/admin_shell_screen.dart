import 'package:flutter/material.dart';
import '../../theme/theme_notifier.dart';
import '../../widgets/common_widgets.dart';
import 'register_member_screen.dart';

class AdminShellScreen extends StatefulWidget {
  const AdminShellScreen({super.key});

  @override
  State<AdminShellScreen> createState() => _AdminShellScreenState();
}

class _AdminShellScreenState extends State<AdminShellScreen> {
  int _tab = 0;

  final _tabs = const [
    _LojaAdminTab(),
    _AgendaAdminTab(),
    _FeedAdminTab(),
    _MembrosAdminTab(),
  ];

  @override
  Widget build(BuildContext context) {
    final ext = context.athlos;
    return Scaffold(
      backgroundColor: ext.backgroundColor,
      body: _tabs[_tab],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: ext.surfaceColor,
          border: Border(top: BorderSide(color: ext.borderColor)),
        ),
        child: BottomNavigationBar(
          currentIndex: _tab,
          onTap: (i) => setState(() => _tab = i),
          backgroundColor: ext.surfaceColor,
          selectedItemColor: ext.primaryColor,
          unselectedItemColor: ext.textSecondary.withOpacity(0.5),
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.store_outlined), activeIcon: Icon(Icons.store), label: 'Loja'),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_today_outlined), activeIcon: Icon(Icons.calendar_today), label: 'Agenda'),
            BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), activeIcon: Icon(Icons.dashboard), label: 'Feed'),
            BottomNavigationBarItem(icon: Icon(Icons.people_outline), activeIcon: Icon(Icons.people), label: 'Membros'),
          ],
        ),
      ),
    );
  }
}

// ─── Admin AppBar ─────────────────────────────────────────────────────────────
class _AdminBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  const _AdminBar({required this.title, this.actions});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final ext = context.athlos;
    return AppBar(
      backgroundColor: ext.surfaceColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: Padding(
        padding: const EdgeInsets.all(10),
        child: CircleAvatar(
          backgroundColor: ext.primaryColor.withOpacity(0.15),
          child: Text('AA', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: ext.primaryColor)),
        ),
      ),
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Athlos Admin', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: ext.textPrimary)),
        Text(title, style: TextStyle(fontSize: 10, color: ext.textSecondary)),
      ]),
      actions: actions ?? [
        IconButton(icon: Icon(Icons.add_circle_outline, color: ext.primaryColor, size: 22), onPressed: () {}),
        IconButton(icon: Icon(Icons.more_vert, color: ext.textSecondary, size: 22), onPressed: () {}),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: ext.borderColor),
      ),
    );
  }
}

// ─── LOJA ADMIN ───────────────────────────────────────────────────────────────
class _LojaAdminTab extends StatelessWidget {
  const _LojaAdminTab();

  @override
  Widget build(BuildContext context) {
    final ext = context.athlos;
    final products = [
      {'name': 'Caneca da Atlética', 'price': 85.00, 'tag': 'CANECAS'},
      {'name': 'Moletom', 'price': 120.00, 'tag': 'ROUPAS'},
      {'name': 'Jersey', 'price': 119.90, 'tag': 'JERSEYS'},
      {'name': 'Bandeira da Atlética', 'price': 45.90, 'tag': 'ACESSÓRIOS'},
    ];

    return Scaffold(
      backgroundColor: ext.backgroundColor,
      appBar: _AdminBar(title: 'GESTÃO DA LOJA'),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ext.primaryColor,
        onPressed: () {},
        mini: true,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header stats
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: ext.surfaceColor, borderRadius: BorderRadius.circular(12), border: Border.all(color: ext.borderColor)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Loja da Atlética', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: ext.textPrimary)),
              const SizedBox(height: 4),
              Text('Todos os Itens', style: TextStyle(fontSize: 11, color: ext.textSecondary)),
              const SizedBox(height: 10),
              Row(children: [
                _StatChip(label: '84 vendas', color: const Color(0xFF10B981)),
                const SizedBox(width: 8),
                _StatChip(label: '44 itens', color: const Color(0xFFF59E0B)),
              ]),
              const SizedBox(height: 12),
              // Filter tabs
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: ['Todos os itens', 'Jerseys', 'Moletons', 'Acessórios'].map((c) {
                  final sel = c == 'Todos os produtos';
                  return Container(
                    margin: const EdgeInsets.only(right: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: sel ? ext.primaryColor : ext.surfaceVariant,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(c, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500,
                        color: sel ? Colors.white : ext.textSecondary)),
                  );
                }).toList()),
              ),
            ]),
          ),
          const SizedBox(height: 14),

          // Product list
          ...products.map((p) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(color: ext.surfaceColor, borderRadius: BorderRadius.circular(12), border: Border.all(color: ext.borderColor)),
            child: Column(children: [
              Container(
                height: 160,
                decoration: BoxDecoration(
                  color: ext.surfaceVariant,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: Center(child: Icon(Icons.checkroom_outlined, size: 48, color: ext.textSecondary.withOpacity(0.25))),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(children: [
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(p['name'] as String, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: ext.textPrimary)),
                    const SizedBox(height: 2),
                    Text('• adicionar tamanhos', style: TextStyle(fontSize: 10, color: ext.textSecondary)),
                  ])),
                  Text('R\$ ${(p['price'] as double).toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: ext.primaryColor)),
                  const SizedBox(width: 10),
                  Icon(Icons.edit_outlined, size: 16, color: ext.textSecondary),
                  const SizedBox(width: 8),
                  const Icon(Icons.delete_outline, size: 16, color: Color(0xFFEF4444)),
                ]),
              ),
            ]),
          )).toList(),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final Color color;
  const _StatChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
      child: Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color)),
    );
  }
}

// ─── AGENDA ADMIN ─────────────────────────────────────────────────────────────
class _AgendaAdminTab extends StatelessWidget {
  const _AgendaAdminTab();

  @override
  Widget build(BuildContext context) {
    final ext = context.athlos;
    final events = [
      {'title': 'Condicionamento físico', 'date': '15 Mai', 'type': 'Treino', 'typeColor': 0xFF10B981, 'hasImage': true},
      {'title': 'Preparação pré-jogo', 'date': '17 Mai', 'type': 'Treino', 'typeColor': 0xFF10B981, 'hasImage': false},
      {'title': 'Inter-Atléticas 2026 – Abertura das Inscrições na Tarde', 'date': '14 Mai', 'type': 'Evento', 'typeColor': 0xFFF59E0B, 'hasImage': false},
      {'title': 'Baile do Tigrão', 'date': '18 Mai', 'type': 'Social', 'typeColor': 0xFF8B5CF6, 'hasImage': true},
    ];

    return Scaffold(
      backgroundColor: ext.backgroundColor,
      appBar: _AdminBar(title: 'GESTÃO DA AGENDA'),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ext.primaryColor,
        onPressed: () {},
        mini: true,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(children: [
            Text('Agenda', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: ext.textPrimary)),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(color: ext.surfaceVariant, borderRadius: BorderRadius.circular(6)),
              child: Text('14/04/2025', style: TextStyle(fontSize: 11, color: ext.textSecondary)),
            ),
          ]),
          const SizedBox(height: 4),

 /*         Row(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: const Color(0xFF10B981).withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
              child: const Text('4 HOJE', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF10B981))),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: const Color(0xFFF59E0B).withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
              child: const Text('12 SEMANA', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFFF59E0B))),
            ),
          ]),
          
  */
          const SizedBox(height: 16),
          ...events.map((e) => _AgendaCard(event: e, ext: ext)).toList(),
        ],
      ),
    );
  }
}

class _AgendaCard extends StatelessWidget {
  final Map<String, dynamic> event;
  final AthlosThemeExtension ext;
  const _AgendaCard({required this.event, required this.ext});

  @override
  Widget build(BuildContext context) {
    final typeColor = Color(event['typeColor'] as int);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(color: ext.surfaceColor, borderRadius: BorderRadius.circular(12), border: Border.all(color: ext.borderColor)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (event['hasImage'] as bool)
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: ext.surfaceVariant,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Center(child: Icon(Icons.image_outlined, size: 36, color: ext.textSecondary.withOpacity(0.3))),
          ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(color: typeColor.withOpacity(0.12), borderRadius: BorderRadius.circular(4)),
                child: Text(event['type'] as String, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: typeColor)),
              ),
              const Spacer(),
              Text(event['date'] as String, style: TextStyle(fontSize: 10, color: ext.textSecondary)),
              const SizedBox(width: 8),
              Icon(Icons.edit_outlined, size: 14, color: ext.textSecondary),
              const SizedBox(width: 6),
              const Icon(Icons.delete_outline, size: 14, color: Color(0xFFEF4444)),
            ]),
            const SizedBox(height: 6),
            Text(event['title'] as String,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: ext.textPrimary, height: 1.3)),
          ]),
        ),
      ]),
    );
  }
}

// ─── FEED ADMIN ───────────────────────────────────────────────────────────────
class _FeedAdminTab extends StatelessWidget {
  const _FeedAdminTab();

  @override
  Widget build(BuildContext context) {
    final ext = context.athlos;
    final posts = [
      {'title': 'Treino de Basquete: Cancelado. Manutenção na Quadra', 'date': '15 Mai', 'type': 'TREINO', 'typeColor': 0xFF10B981, 'urgent': false},
      {'title': 'Inter-Atléticas 2025 – Abertura das Inscrições', 'date': '14 Mai', 'type': 'EVENTO', 'typeColor': 0xFFF59E0B, 'urgent': true},
      {'title': 'Novos Uniformes: Disponíveis para membros Tigre Prime', 'date': '14 Mai', 'type': 'AVISO', 'typeColor': 0xFF2563EB, 'urgent': false},
      {'title': 'Preparação Física: Treinamento Técnico na Tarde', 'date': '16 Mai', 'type': 'TREINO', 'typeColor': 0xFF10B981, 'urgent': false},
    ];

    return Scaffold(
      backgroundColor: ext.backgroundColor,
      appBar: _AdminBar(title: 'GESTÃO DO FEED'),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ext.primaryColor,
        onPressed: () {},
        mini: true,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Search
          TextField(
            style: TextStyle(fontSize: 13, color: ext.textPrimary),
            decoration: InputDecoration(
              hintText: 'Buscar postagens ou avisos...',
              hintStyle: TextStyle(color: ext.textSecondary.withOpacity(0.5), fontSize: 12),
              prefixIcon: Icon(Icons.search, size: 18, color: ext.textSecondary),
              filled: true, fillColor: ext.surfaceVariant,
              isDense: true,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: ext.borderColor)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: ext.borderColor)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: ext.primaryColor, width: 1.5)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
          ),
          const SizedBox(height: 14),
          Text('Postagens Recentes', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: ext.textPrimary)),
          const SizedBox(height: 10),
          ...posts.map((p) {
            final typeColor = Color(p['typeColor'] as int);
            final urgent = p['urgent'] as bool;
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ext.surfaceColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: urgent ? const Color(0xFFEF4444).withOpacity(0.4) : ext.borderColor),
              ),
              child: Row(children: [
                Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(color: typeColor.withOpacity(0.12), borderRadius: BorderRadius.circular(8)),
                  child: Icon(Icons.article_outlined, size: 18, color: typeColor),
                ),
                const SizedBox(width: 10),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(color: typeColor.withOpacity(0.1), borderRadius: BorderRadius.circular(3)),
                      child: Text(p['type'] as String, style: TextStyle(fontSize: 8, fontWeight: FontWeight.w700, color: typeColor)),
                    ),
                    if (urgent) ...[
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        decoration: BoxDecoration(color: const Color(0xFFEF4444).withOpacity(0.1), borderRadius: BorderRadius.circular(3)),
                        child: const Text('URGENTE', style: TextStyle(fontSize: 8, fontWeight: FontWeight.w700, color: Color(0xFFEF4444))),
                      ),
                    ],
                  ]),
                  const SizedBox(height: 4),
                  Text(p['title'] as String,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: ext.textPrimary, height: 1.3),
                    maxLines: 2, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 2),
                  Text(p['date'] as String, style: TextStyle(fontSize: 10, color: ext.textSecondary)),
                ])),
                const SizedBox(width: 8),
                Icon(Icons.edit_outlined, size: 14, color: ext.textSecondary),
                const SizedBox(width: 8),
                const Icon(Icons.delete_outline, size: 14, color: Color(0xFFEF4444)),
              ]),
            );
          }).toList(),
        ],
      ),
    );
  }
}

// ─── MEMBROS ADMIN ────────────────────────────────────────────────────────────
class _MembrosAdminTab extends StatefulWidget {
  const _MembrosAdminTab();

  @override
  State<_MembrosAdminTab> createState() => _MembrosAdminTabState();
}

class _MembrosAdminTabState extends State<_MembrosAdminTab> {
  final List<Map<String, dynamic>> _members = [
    {'name': 'Jailson Mendes', 'role': 'ADMIN', 'status': 'ATIVO', 'isAdmin': true},
    {'name': 'Sarah Connor',       'role': 'MEMBRO', 'status': 'ATIVO', 'isAdmin': false},
    {'name': 'Marky Grayson', 'role': 'MEMBRO', 'status': 'INATIVO', 'isAdmin': false},
    {'name': 'Jimmy Hopkins',    'role': 'MEMBRO', 'status': 'ATIVO', 'isAdmin': false},
    {'name': 'Lara Croft',   'role': 'MEMBRO', 'status': 'ATIVO', 'isAdmin': false},
  ];

  @override
  Widget build(BuildContext context) {
    final ext = context.athlos;

    return Scaffold(
      backgroundColor: ext.backgroundColor,
      appBar: AppBar(
        backgroundColor: ext.surfaceColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: CircleAvatar(
            backgroundColor: ext.primaryColor.withOpacity(0.15),
            child: Text('AA',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: ext.primaryColor)),
          ),
        ),
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Athlos Admin',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: ext.textPrimary)),
          Text('GESTÃO DE MEMBROS',
            style: TextStyle(fontSize: 10, color: ext.textSecondary)),
        ]),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            child: ElevatedButton.icon(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RegisterMemberScreen()),
                );
              },
              icon: const Icon(Icons.person_add, size: 13, color: Colors.white),
              label: const Text('Add New Member',
                style: TextStyle(fontSize: 11, color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: ext.primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: ext.borderColor),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Membros da atlética',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: ext.textPrimary)),
          const SizedBox(height: 12),

          // Search + filter row
          Row(children: [
            Expanded(
              child: TextField(
                style: TextStyle(fontSize: 12, color: ext.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Buscar membro...',
                  hintStyle: TextStyle(color: ext.textSecondary.withOpacity(0.5), fontSize: 12),
                  prefixIcon: Icon(Icons.search, size: 16, color: ext.textSecondary),
                  filled: true, fillColor: ext.surfaceVariant, isDense: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: ext.borderColor)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: ext.borderColor)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: ext.primaryColor, width: 1.5)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
              decoration: BoxDecoration(
                color: ext.surfaceVariant,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: ext.borderColor),
              ),
              child: Row(children: [
                Text('Ativos', style: TextStyle(fontSize: 12, color: ext.textSecondary)),
                const SizedBox(width: 4),
                Icon(Icons.expand_more, size: 14, color: ext.textSecondary),
              ]),
            ),
          ]),
          const SizedBox(height: 14),

          // Member cards
          ..._members.map((m) {
            final isAdmin = m['isAdmin'] as bool;
            final isActive = m['status'] == 'ATIVO';
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ext.surfaceColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isAdmin ? ext.primaryColor.withOpacity(0.3) : ext.borderColor),
              ),
              child: Row(children: [
                AthlosAvatar(name: m['name'] as String, size: 40),
                const SizedBox(width: 10),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(m['name'] as String,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: ext.textPrimary)),
                  Text(m['role'] as String,
                    style: TextStyle(fontSize: 10, color: ext.textSecondary)),
                ])),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(
                    color: isActive
                      ? const Color(0xFF10B981).withOpacity(0.1)
                      : const Color(0xFFEF4444).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(m['status'] as String,
                    style: TextStyle(
                      fontSize: 9, fontWeight: FontWeight.w700,
                      color: isActive ? const Color(0xFF10B981) : const Color(0xFFEF4444))),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: ext.surfaceVariant, borderRadius: BorderRadius.circular(6)),
                    child: Text('Edit', style: TextStyle(fontSize: 10, color: ext.textSecondary)),
                  ),
                ),
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: () => setState(() => _members.remove(m)),
                  child: const Icon(Icons.delete_outline, size: 16, color: Color(0xFFEF4444)),
                ),
              ]),
            );
          }).toList(),

          // Pagination
          const SizedBox(height: 8),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ...List.generate(4, (i) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: 28, height: 28,
              decoration: BoxDecoration(
                color: i == 0 ? ext.primaryColor : ext.surfaceVariant,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: i == 0 ? ext.primaryColor : ext.borderColor),
              ),
              child: Center(child: Text('${i + 1}',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600,
                    color: i == 0 ? Colors.white : ext.textSecondary))),
            )),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: 28, height: 28,
              decoration: BoxDecoration(
                color: ext.surfaceVariant,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: ext.borderColor)),
              child: Icon(Icons.chevron_right, size: 14, color: ext.textSecondary),
            ),
          ]),
        ],
      ),
    );
  }
}
