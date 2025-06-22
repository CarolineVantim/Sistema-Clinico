import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistema_clinico/shared/constants/constants.dart';

import '../../../main.dart';
import 'widgets/menu_item_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userName;

  final List<MenuItemCard> features = const [
    MenuItemCard(
      titulo: 'NOVO ATENDIMENTO',
      resourceEnum: ImageResourceEnum.autism,
      route: Routes.treatmentDescription,
    ),
    MenuItemCard(
      titulo: 'AGENDAMENTOS',
      resourceEnum: ImageResourceEnum.calendar,
      route: Routes.appointments,
    ),
    MenuItemCard(
      titulo: 'PACIENTES',
      resourceEnum: ImageResourceEnum.children,
      route: Routes.students,
    ),
    MenuItemCard(
      titulo: 'CONFIGURAÇÕES',
      resourceEnum: ImageResourceEnum.source,
      route: Routes.settings,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('username') ?? 'Usuário';
    });
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    Navigator.pushReplacementNamed(context, Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Início'),
        actions: [
          TextButton(
            onPressed: _logout,
            child: const Text('SAIR', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          _buildWelcomeCard(context),
          const SizedBox(height: 16),
          Text(
            'NAVEGUE POR',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          _buildGrid(),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard(BuildContext context) {
    return Card.outlined(
      color: const Color(0xFF257A9F),
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Avatar ou ícone
            Container(
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child: const Icon(Icons.person, size: 40),
            ),
            const SizedBox(width: 16),
            // Textos de boas-vindas
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Olá, ${userName ?? ''}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Bem-vindo ao seu Dashboard',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white70,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: features.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          final item = features[index];
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, item.route),
            child: item,
          );
        },
      ),
    );
  }
}
