# 🏆 Athlos — Flutter Frontend

App de gestão de atlética universitária — implementação Flutter pixel-perfect baseada no design Figma.

---

## 📁 Estrutura do Projeto

```
lib/
├── main.dart                        # Entry point + AppNavigator (seletor de telas)
├── theme/
│   └── app_theme.dart               # Cores, tipografia, tema Material 3
├── models/
│   └── mock_data.dart               # Dados mockados (sem backend)
├── widgets/
│   └── common_widgets.dart          # Widgets reutilizáveis
└── screens/
    ├── landing_screen.dart          # Tela inicial "Sua Atlética no Topo"
    ├── onboarding_create_screen.dart # Fluxo "Crie sua Atlética" (3 etapas)
    ├── home_screen.dart             # App Mobile com Bottom Nav (5 abas)
    ├── admin_dashboard_screen.dart  # Painel Admin com Sidebar + Dashboard
    └── admin_form_screens.dart      # Formulários: Membro, Postagem, Evento, Produto
```

---

## 🎨 Design System

### Cores (hex)
| Token           | Hex         | Uso                          |
|-----------------|-------------|------------------------------|
| `primary`       | `#2563EB`   | Botões, links, ícones ativos |
| `primaryDark`   | `#1D4ED8`   | Gradientes, hover            |
| `success`       | `#10B981`   | Status ativo, gráficos       |
| `warning`       | `#F59E0B`   | Alertas, eventos             |
| `error`         | `#EF4444`   | Deletar, inativo             |
| `background`    | `#F8FAFC`   | Fundo geral                  |
| `surface`       | `#FFFFFF`   | Cards, AppBar                |
| `surfaceVariant`| `#F1F5F9`   | Inputs, chips                |
| `border`        | `#E2E8F0`   | Bordas de cards              |
| `textPrimary`   | `#0F172A`   | Títulos                      |
| `textSecondary` | `#64748B`   | Labels, subtítulos           |
| `textTertiary`  | `#94A3B8`   | Placeholders, ícones         |

### Tipografia
- **Font**: Google Fonts — Inter
- Títulos: `700–900` weight
- Corpo: `400–500` weight
- Labels: `600` weight, letter-spacing: `0.2–0.5`

### Border Radius
- Cards: `12px`
- Botões: `8px`
- Chips/badges: `100px` (pill)
- Avatares: `circle`

---

## 📱 Telas Implementadas

### 1. AppNavigator (main.dart)
Tela de entrada com menu de navegação para todas as telas do app.
Dark background `#0F172A` com tiles brancos semitransparentes.

### 2. LandingScreen
- Background azul primário com logo ATHLOS
- Headline "SUA ATLÉTICA NO TOPO"
- Feature pills (Membros, Eventos, Loja...)
- Card branco inferior com botões CTA
- Navegação → OnboardingCreateScreen

### 3. OnboardingCreateScreen
Stepper de 3 etapas com progress indicator:
- **Etapa 1**: Nome, Instituição, Localização + upload de logo
- **Etapa 2**: Seleção de papel (Presidente/Diretor/Membro) com cards selecionáveis
- **Etapa 3**: Cor principal, descrição + preview card com gradiente

### 4. HomeScreen (Mobile)
BottomNavigationBar com 5 abas:
- **Início**: Feed de avisos com cards de postagens, quick actions
- **Avisos**: Lista de notificações com aviso de alerta destacado
- **Loja**: Grid de produtos com filtros por categoria, totalizador de vendas
- **Agenda**: Lista de membros para confirmar presença
- **Perfil**: Card de perfil + menu de configurações

### 5. AdminDashboardScreen
Layout de dois painéis (Sidebar + Content):
- **Sidebar**: Logo, info do usuário, nav items
- **Dashboard**: Cards de estatísticas + BarChart (receita mensal) + PieChart (categorias)
- **Lojinha**: Grid de produtos com ações de editar/deletar
- **Agenda**: Lista de eventos/treinos com badges de tipo
- **Postagens**: Lista gerenciável de posts
- **Membros**: Tabela com avatar, nome, papel, status, data e ações

### 6. Formulários Admin
- **RegisterMemberScreen**: Nome, email, telefone + seletor de papel (chips)
- **NewPostScreen**: Título, conteúdo, upload de imagem, seletor de visibilidade
- **NewEventScreen**: Nome, descrição, data/hora, local, tipo de evento
- **NewProductScreen**: Grid de imagens, nome, descrição, preço, estoque, categoria

---

## 🧱 Widgets Reutilizáveis

| Widget          | Descrição                                               |
|-----------------|---------------------------------------------------------|
| `AthlosButton`  | Botão primário/outlined/small com ícone opcional        |
| `AthlosInput`   | TextField com label, prefix/suffix icon                 |
| `AthlosCard`    | Container com border, borderRadius e sombra sutil       |
| `AthlosAvatar`  | Avatar circular com iniciais + indicator online         |
| `AthlosAppBar`  | AppBar com logo ou título + divider inferior            |
| `StatusBadge`   | Pill colorida para status (Ativo/Inativo/Pendente)      |
| `StatCard`      | Card de estatística com ícone colorido + valor          |
| `SectionHeader` | Título de seção com link de ação opcional               |

---

## ⚙️ Setup

```bash
# 1. Verificar Flutter
flutter doctor

# 2. Instalar dependências
flutter pub get

# 3. Rodar no emulador ou dispositivo
flutter run

# 4. Para web (admin dashboard fica melhor)
flutter run -d chrome
```

### Dependências
```yaml
flutter: sdk
google_fonts: ^6.1.0   # Tipografia Inter
fl_chart: ^0.66.2      # Gráficos de barra e pizza
cached_network_image: ^3.3.0
```

---

## 🔄 Navegação

```
AppNavigator
├── LandingScreen → OnboardingCreateScreen → HomeScreen
├── HomeScreen (5 abas com Navigator local)
├── AdminDashboardScreen (Sidebar com estado local)
│   ├── → RegisterMemberScreen
│   ├── → NewPostScreen
│   ├── → NewEventScreen
│   └── → NewProductScreen
├── NewPostScreen
└── NewEventScreen
```

---

## 📌 Notas de Implementação

- **Sem backend**: todos os dados vêm de `MockData` em `mock_data.dart`
- **Responsividade**: Admin Dashboard usa `Row` com sidebar fixa (220px) — ideal para tablet/web; mobile usa BottomNav
- **Charts**: `fl_chart` para BarChart e PieChart no dashboard admin
- **Estado**: `StatefulWidget` apenas onde necessário (seletores, steps, bottom nav)
- **Arquitetura**: Widget-first, sem state management externo (escopo de UI only)
