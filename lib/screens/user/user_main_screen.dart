import 'package:athlos/theme/app_theme.dart';
import 'package:athlos/widgets/common_widgets.dart';
import 'package:flutter/material.dart';

class UserMainScreen extends StatefulWidget {
  const UserMainScreen({super.key});

  @override
  State<UserMainScreen> createState() => _UserMainScreenState();
}

class _UserMainScreenState extends State<UserMainScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final ext = context.athlos;
    final tabs = [
      const _FeedTab(),
      const _LojaTab(),
      const _AgendaTab(),
      const _ParticipantesTab(),
      const _PerfilTab(),
    ];

    return Scaffold(
      backgroundColor: ext.backgroundColor,
      body: tabs[_index],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: ext.surfaceColor,
          border: Border(top: BorderSide(color: ext.borderColor)),
        ),
        child: BottomNavigationBar(
          currentIndex: _index,
          onTap: (i) => setState(() => _index = i),
          backgroundColor: ext.surfaceColor,
          selectedItemColor: ext.primaryColor,
          unselectedItemColor: ext.textSecondary.withOpacity(0.6),
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Início'),
            BottomNavigationBarItem(icon: Icon(Icons.store_outlined), activeIcon: Icon(Icons.store), label: 'Loja'),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_today_outlined), activeIcon: Icon(Icons.calendar_today), label: 'Agenda'),
            BottomNavigationBarItem(icon: Icon(Icons.people_outline), activeIcon: Icon(Icons.people), label: 'Membros'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Perfil'),
          ],
        ),
      ),
    );
  }
}

// ─── AppBar padrão do usuário ─────────────────────────────────────────────────
class _UserAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  const _UserAppBar({this.actions});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final ext = context.athlos;
    return AppBar(
      backgroundColor: ext.surfaceColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Container(
            width: 28, height: 28,
            decoration: BoxDecoration(color: ext.primaryColor, borderRadius: BorderRadius.circular(6)),
            child: const Icon(Icons.sports, color: Colors.white, size: 16),
          ),
          const SizedBox(width: 8),
          Text('ATHLOS', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: ext.textPrimary, letterSpacing: 2)),
        ],
      ),
      actions: actions ?? [
        IconButton(icon: Icon(Icons.search, color: ext.textSecondary, size: 22), onPressed: () {}),
        IconButton(icon: Icon(Icons.notifications_outlined, color: ext.textSecondary, size: 22), onPressed: () {}),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: ext.borderColor),
      ),
    );
  }
}

// ─── FEED TAB ─────────────────────────────────────────────────────────────────
class _FeedTab extends StatefulWidget {
  const _FeedTab();
  @override
  State<_FeedTab> createState() => _FeedTabState();
}

class _FeedTabState extends State<_FeedTab> {
  String _filter = 'RECENTES';

  @override
  Widget build(BuildContext context) {
    final ext = context.athlos;
    return Scaffold(
      backgroundColor: ext.backgroundColor,
      appBar: _UserAppBar(),
      body: Column(
        children: [
          // Aviso destaque
          Container(
            margin: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [ext.primaryColor, ext.primaryColor.withBlue(255)],
                begin: Alignment.topLeft, end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(4)),
                        child: const Text('AVISO', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: 1)),
                      ),
                      const SizedBox(height: 8),
                      const Text('Novo Regulamento de Treinos:\nTemporada 2026.',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white, height: 1.2)),
                      const SizedBox(height: 6),
                      Text('Confira as atualizações obrigatórias para o uso das instalações contra a partir d...',
                        style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.8), height: 1.4)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Filter chips
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ['RECENTES', 'PRESIDÊNCIA', 'ESPORTES'].map((f) {
                  final sel = f == _filter;
                  return GestureDetector(
                    onTap: () => setState(() => _filter = f),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                      decoration: BoxDecoration(
                        color: sel ? ext.primaryColor : ext.surfaceColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: sel ? ext.primaryColor : ext.borderColor),
                      ),
                      child: Text(f, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600,
                          color: sel ? Colors.white : ext.textSecondary)),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // Posts
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _PostCard(
                  category: 'PRESIDÊNCIA',
                  categoryColor: ext.primaryColor,
                  title: 'Informamos que a assembleia geral foi reagendada para a próxima sexta-feira de 18:00 no auditório principal.',
                  timeAgo: '2h atrás',
                  likes: 12, comments: 3,
                  ext: ext,
                ),
                const SizedBox(height: 10),
                _PostCard(
                  category: 'TREINO',
                  categoryColor: const Color(0xFF10B981),
                  title: 'Circuito de alta intensidade disponível na pista 2 hoje à tarde. Foco em explosão e resistência.',
                  timeAgo: '4h atrás',
                  likes: 28, comments: 7,
                  hasImage: true,
                  ext: ext,
                ),
                const SizedBox(height: 10),
                _PostCard(
                  category: 'COMPETIÇÃO',
                  categoryColor: const Color(0xFFF59E0B),
                  title: 'Confira o chaveamento das semifinais do torneio inter-clubes. Boa sorte a todos os atletas!',
                  timeAgo: '1d atrás',
                  likes: 45, comments: 18,
                  ext: ext,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  final String category;
  final Color categoryColor;
  final String title;
  final String timeAgo;
  final int likes;
  final int comments;
  final bool hasImage;
  final AthlosThemeExtension ext;

  const _PostCard({
    required this.category, required this.categoryColor, required this.title,
    required this.timeAgo, required this.likes, required this.comments,
    this.hasImage = false, required this.ext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ext.surfaceColor, borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ext.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AthlosAvatar(name: category, size: 30),
              const SizedBox(width: 8),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(category, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: ext.textPrimary)),
                Text(timeAgo, style: TextStyle(fontSize: 10, color: ext.textSecondary)),
              ])),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(color: categoryColor.withOpacity(0.12), borderRadius: BorderRadius.circular(4)),
                child: Text(category, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: categoryColor)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(title, style: TextStyle(fontSize: 13, color: ext.textPrimary, height: 1.45)),
          if (hasImage) ...[
            const SizedBox(height: 10),
            Container(
              height: 100, decoration: BoxDecoration(
                color: ext.surfaceVariant, borderRadius: BorderRadius.circular(8),
              ),
              child: Center(child: Icon(Icons.image_outlined, size: 32, color: ext.textSecondary.withOpacity(0.4))),
            ),
          ],
          const SizedBox(height: 10),
          Row(children: [
            Icon(Icons.thumb_up_outlined, size: 14, color: ext.textSecondary),
            const SizedBox(width: 4),
            Text('$likes', style: TextStyle(fontSize: 11, color: ext.textSecondary)),
            const SizedBox(width: 14),
            Icon(Icons.comment_outlined, size: 14, color: ext.textSecondary),
            const SizedBox(width: 4),
            Text('$comments', style: TextStyle(fontSize: 11, color: ext.textSecondary)),
            const Spacer(),
            Icon(Icons.share_outlined, size: 14, color: ext.textSecondary),
          ]),
        ],
      ),
    );
  }
}

// ─── LOJA TAB ─────────────────────────────────────────────────────────────────
class _LojaTab extends StatefulWidget {
  const _LojaTab();
  @override
  State<_LojaTab> createState() => _LojaTabState();
}

class _LojaTabState extends State<_LojaTab> {
  String _cat = 'Todos os itens';

  final List<Map<String, dynamic>> _products = const [
    {'name': 'Caneca da Atlética', 'price': 85.00, 'tag': 'Canecas'}, //Mudar os nomes
    {'name': 'Moletom', 'price': 289.90, 'tag': 'Moletons'},
    {'name': 'Jersey', 'price': 119.90, 'tag': 'Jerseys'},
    {'name': 'Bandeira da Atlética', 'price': 45.90, 'tag': 'Acessórios'},
  ];

  @override
  Widget build(BuildContext context) {
    final ext = context.athlos;
    return Scaffold(
      backgroundColor: ext.backgroundColor,
      appBar: _UserAppBar(),
      body: ListView(
        children: [
          // Banner coleção
          Container(
            margin: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            height: 130,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [ext.primaryColor.withOpacity(0.9), Colors.black87]),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Center(
              child: Text('COLEÇÃO 2026',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 2)),
            ),
          ),

          // Categorias
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ['Todos os itens', 'Motelons', 'Jerseys', 'Acessórios'].map((c) {
                  final sel = c == _cat;
                  return GestureDetector(
                    onTap: () => setState(() => _cat = c),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                      decoration: BoxDecoration(
                        color: sel ? ext.primaryColor : ext.surfaceColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: sel ? ext.primaryColor : ext.borderColor),
                      ),
                      child: Text(c, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500,
                          color: sel ? Colors.white : ext.textSecondary)),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          const SizedBox(height: 14),

          // Grid
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10,
              childAspectRatio: 0.76,
              children: _products.map((p) => _ProductCard(product: p, ext: ext)).toList(),
            ),
          ),

          // Loyalty banner
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ext.primaryColor, borderRadius: BorderRadius.circular(12),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('PROGRAMA DE FIDELIDADE', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Colors.white70, letterSpacing: 1.5)),
              const SizedBox(height: 4),
              const Text('TIGRE PRIME', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white)),
              const SizedBox(height: 4),
              Text('Acesso antecipado ao novos lançamentos.', style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.8))),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
                child: Text('SAIBA MAIS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: ext.primaryColor)),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final AthlosThemeExtension ext;
  const _ProductCard({required this.product, required this.ext});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: ext.surfaceColor, borderRadius: BorderRadius.circular(12), border: Border.all(color: ext.borderColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: ext.surfaceVariant, borderRadius: const BorderRadius.vertical(top: Radius.circular(12))),
              child: Center(child: Icon(Icons.checkroom_outlined, size: 44, color: ext.textSecondary.withOpacity(0.3))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(product['name'], style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: ext.textPrimary), maxLines: 2),
              const SizedBox(height: 6),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('R\$ ${product['price'].toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: ext.primaryColor)),
                Container(
                  width: 26, height: 26,
                  decoration: BoxDecoration(color: ext.primaryColor, borderRadius: BorderRadius.circular(6)),
                  child: const Icon(Icons.add, size: 14, color: Colors.white),
                ),
              ]),
            ]),
          ),
        ],
      ),
    );
  }
}

// ─── AGENDA TAB ───────────────────────────────────────────────────────────────
class _AgendaTab extends StatefulWidget {
  const _AgendaTab();
  @override
  State<_AgendaTab> createState() => _AgendaTabState();
}

class _AgendaTabState extends State<_AgendaTab> {
  String _filter = 'Todo';

  final List<Map<String, dynamic>> _events = const [
    {
      'date': 'JUN 14', 'type': 'TREINO', 'typeColor': 0xFF10B981,
      'title': 'TREINO DE FUTEBOL',
      'time': '19:00 – 21:00', 'place': 'Campo de Treinamento Alpha',
      'bgColor': 0xFF1E3A5F,
    },
    {
      'date': 'JUN 18', 'type': 'EVENTO SOCIAL', 'typeColor': 0xFFF59E0B,
      'title': 'FESTA DA ATLÉTICA',
      'time': '22:00 – 04:00', 'place': 'Club Hype – Setor Sul',
      'bgColor': 0xFF3A1E5F,
    },
    {
      'date': 'JUN 22', 'type': 'COMPETIÇÃO', 'typeColor': 0xFFEF4444,
      'title': 'INTER-ATLÉTICAS 2026',
      'time': '08:00 – 18:00', 'place': 'Ginásio Poliesportivo Central',
      'bgColor': 0xFF1E3A2F,
    },
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
        title: Text('Agenda', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: ext.textPrimary)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: ext.borderColor),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: Text('Fique por dentro dos seus compromissos.', style: TextStyle(fontSize: 12, color: ext.textSecondary)),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ['Todo', 'Treinos', 'Eventos', 'Competições'].map((f) {
                  final sel = f == _filter;
                  return GestureDetector(
                    onTap: () => setState(() => _filter = f),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                      decoration: BoxDecoration(
                        color: sel ? ext.primaryColor : ext.surfaceColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: sel ? ext.primaryColor : ext.borderColor),
                      ),
                      child: Text(f, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500,
                          color: sel ? Colors.white : ext.textSecondary)),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _events.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) => _EventCard(event: _events[i], ext: ext),
            ),
          ),
        ],
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  final Map<String, dynamic> event;
  final AthlosThemeExtension ext;
  const _EventCard({required this.event, required this.ext});

  @override
  Widget build(BuildContext context) {
    final typeColor = Color(event['typeColor'] as int);
    return Container(
      decoration: BoxDecoration(
        color: Color(event['bgColor'] as int),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
            child: Row(children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: typeColor.withOpacity(0.25), borderRadius: BorderRadius.circular(4)),
                child: Text(event['type'], style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: typeColor, letterSpacing: 0.5)),
              ),
              const Spacer(),
              Text(event['date'], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white70)),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
            child: Text(event['title'],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white, height: 1.1)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 8, 14, 0),
            child: Row(children: [
              const Icon(Icons.access_time, size: 12, color: Colors.white60),
              const SizedBox(width: 4),
              Text(event['time'], style: const TextStyle(fontSize: 11, color: Colors.white60)),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 4, 14, 14),
            child: Row(children: [
              const Icon(Icons.location_on_outlined, size: 12, color: Colors.white60),
              const SizedBox(width: 4),
              Text(event['place'], style: const TextStyle(fontSize: 11, color: Colors.white60)),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.check_circle_outline, size: 14, color: Colors.white),
                label: const Text('Confirmar Presença', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ext.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── PARTICIPANTES TAB ────────────────────────────────────────────────────────
class _ParticipantesTab extends StatelessWidget {
  const _ParticipantesTab();

  @override
  Widget build(BuildContext context) {
    final ext = context.athlos;
    final members = [
      {'rank': 1, 'name': 'Gabriel Breier', 'role': 'PRESIDENTE', 'isPresident': true},
      {'rank': 2, 'name': 'Tiago Potter', 'role': 'VICE-PRESIDENTE', 'isPresident': false},
      {'rank': 3, 'name': 'Lucas Oliveira', 'role': 'FINANCEIRO', 'isPresident': false},
      {'rank': 4, 'name': 'Mariana Costa', 'role': 'MARKETING', 'isPresident': false},
      {'rank': 5, 'name': 'Ricardo Silva', 'role': 'DIRETOR', 'isPresident': false},
      {'rank': 24, 'name': 'Daniel Aguiar (Você)', 'role': 'MEMBRO COMUM', 'isPresident': false},
    ];

    return Scaffold(
      backgroundColor: ext.backgroundColor,
      appBar: AppBar(
        backgroundColor: ext.surfaceColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text('Participantes da Atlética', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: ext.textPrimary)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: ext.borderColor),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: TextField(
              style: TextStyle(fontSize: 13, color: ext.textPrimary),
              decoration: InputDecoration(
                hintText: 'Buscar participante...',
                hintStyle: TextStyle(color: ext.textSecondary.withOpacity(0.5), fontSize: 13),
                prefixIcon: Icon(Icons.search, size: 18, color: ext.textSecondary),
                filled: true, fillColor: ext.surfaceVariant,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: ext.borderColor)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: ext.borderColor)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: ext.primaryColor, width: 1.5)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: members.length,
              itemBuilder: (_, i) {
                final m = members[i];
                final isPresident = m['isPresident'] as bool;
                final isMe = (m['rank'] as int) == 24;
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isPresident ? ext.primaryColor : ext.surfaceColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: isMe ? ext.primaryColor : ext.borderColor,
                      width: isMe ? 1.5 : 1),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 28,
                        child: Text('${m['rank']}',
                          style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700,
                            color: isPresident ? Colors.white : ext.textSecondary,
                          )),
                      ),
                      AthlosAvatar(name: m['name'] as String, size: 40),
                      const SizedBox(width: 12),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        if (isPresident)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(color: Colors.white.withOpacity(0.25), borderRadius: BorderRadius.circular(4)),
                            child: const Text('Presidente', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: Colors.white)),
                          ),
                        Text(m['name'] as String,
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,
                            color: isPresident ? Colors.white : ext.textPrimary)),
                        Text(m['role'] as String,
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500,
                            color: isPresident ? Colors.white70 : ext.textSecondary)),
                      ])),
                      if (isMe)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: ext.primaryColor.withOpacity(0.12), borderRadius: BorderRadius.circular(6)),
                          child: Text('Você', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: ext.primaryColor)),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─── PERFIL TAB ───────────────────────────────────────────────────────────────
class _PerfilTab extends StatelessWidget {
  const _PerfilTab();

  @override
  Widget build(BuildContext context) {
    final ext = context.athlos;
    return Scaffold(
      backgroundColor: ext.backgroundColor,
      appBar: _UserAppBar(),
      body: ListView(
        children: [
          // Header perfil
          Container(
            color: ext.surfaceColor,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 80, height: 80,
                      decoration: BoxDecoration(
                        color: ext.primaryColor.withOpacity(0.15),
                        shape: BoxShape.circle,
                        border: Border.all(color: ext.primaryColor, width: 2.5),
                      ),
                      child: Center(child: Text('PA', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: ext.primaryColor))),
                    ),
                    Positioned(
                      bottom: 0, right: 0,
                      child: Container(
                        width: 24, height: 24,
                        decoration: BoxDecoration(color: ext.primaryColor, shape: BoxShape.circle),
                        child: const Icon(Icons.edit, color: Colors.white, size: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text('Daniel Aguiar',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: ext.textPrimary)),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(color: ext.primaryColor, borderRadius: BorderRadius.circular(20)),
                  child: const Text('Cargo: Membro', style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Administração
          _SectionGroup(title: 'ADMINISTRAÇÃO', ext: ext, items: [
            _MenuItem(icon: Icons.people_outline, label: 'Gestão de Associados', ext: ext),
            _MenuItem(icon: Icons.payment_outlined, label: 'Meus Pagamentos', ext: ext),
            _MenuItem(icon: Icons.settings_outlined, label: 'Configurações da Conta', ext: ext),
          ]),

          const SizedBox(height: 8),

          // Sessão
          _SectionGroup(title: 'SESSÃO', ext: ext, items: [
            _MenuItem(icon: Icons.logout, label: 'Sair da Conta', ext: ext, isDestructive: true,
              onTap: () => Navigator.of(context).popUntil((r) => r.isFirst)),
          ]),

          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: ext.primaryColor,
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text('Configurações', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

class _SectionGroup extends StatelessWidget {
  final String title;
  final List<Widget> items;
  final AthlosThemeExtension ext;
  const _SectionGroup({required this.title, required this.items, required this.ext});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Text(title, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700,
              color: ext.textSecondary, letterSpacing: 0.8)),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: ext.surfaceColor, borderRadius: BorderRadius.circular(12),
            border: Border.all(color: ext.borderColor),
          ),
          child: Column(
            children: items.asMap().entries.map((e) {
              final isLast = e.key == items.length - 1;
              return Column(children: [
                e.value,
                if (!isLast) Divider(height: 1, color: ext.borderColor, indent: 16, endIndent: 16),
              ]);
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final AthlosThemeExtension ext;
  final bool isDestructive;
  final VoidCallback? onTap;
  const _MenuItem({required this.icon, required this.label, required this.ext,
    this.isDestructive = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? const Color(0xFFEF4444) : ext.textPrimary;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        child: Row(children: [
          Container(
            width: 32, height: 32,
            decoration: BoxDecoration(
              color: isDestructive ? const Color(0xFFEF4444).withOpacity(0.1) : ext.surfaceVariant,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: TextStyle(fontSize: 14, color: color, fontWeight: FontWeight.w500))),
          Icon(Icons.chevron_right, size: 18, color: ext.textSecondary.withOpacity(0.5)),
        ]),
      ),
    );
  }
}
