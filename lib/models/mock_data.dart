class UserModel {
  final String id;
  final String name;
  final String role;
  final String avatarUrl;
  final bool isOnline;

  const UserModel({
    required this.id,
    required this.name,
    required this.role,
    this.avatarUrl = '',
    this.isOnline = false,
  });
}

class PostModel {
  final String id;
  final String title;
  final String content;
  final String imageUrl;
  final String author;
  final String timeAgo;
  final int likes;
  final int comments;

  const PostModel({
    required this.id,
    required this.title,
    required this.content,
    this.imageUrl = '',
    required this.author,
    required this.timeAgo,
    this.likes = 0,
    this.comments = 0,
  });
}

class EventModel {
  final String id;
  final String title;
  final String description;
  final String date;
  final String location;
  final String imageUrl;
  final bool isHighlighted;

  const EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    this.imageUrl = '',
    this.isHighlighted = false,
  });
}

class ProductModel {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String category;
  final bool inStock;

  const ProductModel({
    required this.id,
    required this.name,
    required this.price,
    this.imageUrl = '',
    required this.category,
    this.inStock = true,
  });
}

class MemberModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final String status;
  final String joinDate;

  const MemberModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.status,
    required this.joinDate,
  });
}

class MockData {
  static const UserModel currentUser = UserModel(
    id: '1',
    name: 'Pedro Alves',
    role: 'Presidente',
    isOnline: true,
  );

  static const List<PostModel> posts = [
    PostModel(
      id: '1',
      title: 'Não Regularizou os Pedidos Futuro e...',
      content: 'Alerta importante para todos os membros sobre a regularização...',
      author: 'Admin',
      timeAgo: '2h atrás',
      likes: 12,
      comments: 3,
    ),
    PostModel(
      id: '2',
      title: 'TREINO EM FUTEBOL',
      content: 'Novo treino disponível para os membros da atlética.',
      author: 'Coordenador',
      timeAgo: '5h atrás',
      likes: 24,
      comments: 8,
    ),
    PostModel(
      id: '3',
      title: 'ESTAMPAS 2026',
      content: 'Confira as novas estampas disponíveis para o ano.',
      author: 'Design',
      timeAgo: '1d atrás',
      likes: 45,
      comments: 15,
    ),
    PostModel(
      id: '4',
      title: 'INTER-ATLÉTICAS 2026',
      content: 'Prepare-se para o maior evento do ano!',
      author: 'Eventos',
      timeAgo: '2d atrás',
      likes: 67,
      comments: 22,
    ),
  ];

  static const List<EventModel> events = [
    EventModel(
      id: '1',
      title: 'Festa da Atlética',
      description: 'A maior festa da temporada está chegando.',
      date: '15 Abr 2026',
      location: 'Ginásio Principal',
      isHighlighted: true,
    ),
    EventModel(
      id: '2',
      title: 'Treino Funcional',
      description: 'Treino especial para todos os membros.',
      date: '18 Abr 2026',
      location: 'Quadra A',
    ),
    EventModel(
      id: '3',
      title: 'Campeonato Interno',
      description: 'Disputa entre as equipes da atlética.',
      date: '22 Abr 2026',
      location: 'Campo Central',
    ),
  ];

  static const List<ProductModel> products = [
    ProductModel(
      id: '1',
      name: 'Casaco',
      price: 80.00,
      category: 'Vestuário',
    ),
    ProductModel(
      id: '2',
      name: 'Moletom',
      price: 120.00,
      category: 'Vestuário',
    ),
    ProductModel(
      id: '3',
      name: 'Starter Pro Tee',
      price: 48.00,
      category: 'Camisetas',
    ),
    ProductModel(
      id: '4',
      name: 'Apex Field Shorts',
      price: 59.06,
      category: 'Shorts',
    ),
  ];

  static const List<MemberModel> members = [
    MemberModel(
      id: '1',
      name: 'Junior Alexandre',
      email: 'junior@atletica.com',
      role: 'Membro',
      status: 'Ativo',
      joinDate: '01/01/2026',
    ),
    MemberModel(
      id: '2',
      name: 'Sara Lopes',
      email: 'sara@atletica.com',
      role: 'Membro',
      status: 'Ativo',
      joinDate: '15/01/2026',
    ),
    MemberModel(
      id: '3',
      name: 'Flor Luz Rodrigues',
      email: 'flor@atletica.com',
      role: 'Coordenadora',
      status: 'Ativo',
      joinDate: '20/12/2025',
    ),
    MemberModel(
      id: '4',
      name: 'Elena Batista',
      email: 'elena@atletica.com',
      role: 'Membro',
      status: 'Inativo',
      joinDate: '05/02/2026',
    ),
    MemberModel(
      id: '5',
      name: 'David Thompson',
      email: 'david@atletica.com',
      role: 'Membro',
      status: 'Ativo',
      joinDate: '10/03/2026',
    ),
  ];

  static const List<Map<String, dynamic>> agendaItems = [
    {
      'date': '04/05/2025',
      'title': 'Treino Strong R & Conditioning',
      'type': 'training',
    },
    {
      'date': '04/20/2025',
      'title': 'INTER-ATLÉTICAS 2025',
      'type': 'event',
    },
    {
      'date': '05/01/2025',
      'title': 'Morning Strong R & Conditioning',
      'type': 'training',
    },
    {
      'date': '05/15/2025',
      'title': 'Season End Wounds Gala',
      'type': 'event',
    },
  ];

  static const double totalRevenue = 42700.00;
  static const int totalMembers = 84;
}
