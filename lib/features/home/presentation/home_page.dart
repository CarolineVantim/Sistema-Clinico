import 'package:flutter/material.dart';
import 'package:sistema_clinico/shared/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import 'widgets/menu_item_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userName;

  final features = const [
    MenuItemCard(
      titulo: 'ATENDIMENTO',
      resourceEnum: ImageResourceEnum.autism,
      route: Routes.appointment,
    ),
    MenuItemCard(
      titulo: 'AGENDA',
      resourceEnum: ImageResourceEnum.calendar,
      route: Routes.appointments,
    ),
    MenuItemCard(
      titulo: 'CLIENTES',
      resourceEnum: ImageResourceEnum.children,
      route: Routes.patients,
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

  void _logout() {
    Navigator.pushReplacementNamed(context, Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userName == null
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Column(
                children: [
                  // Top Header
                  Stack(
                    children: [
                      Container(
                        height: 180,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Color(0xFFC7DDE3),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 16,
                        right: 16,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            const Icon(
                              Icons.notifications,
                              size: 28,
                              color: Colors.black54,
                            ),
                            Positioned(
                              top: 2,
                              right: 2,
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  '3',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 32,
                        child: CircleAvatar(
                          radius: 35,
                          backgroundColor: const Color(0xFFE8DAB2),
                          child: Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.deepPurple.shade700,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 110,
                        top: 48,
                        child: Text(
                          'Olá, $userName',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Navegue Por
                  const Text(
                    'Navegue por',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF9B0036),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Grid de menus
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GridView.builder(
                        itemCount: features.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, features[index].route);
                            },
                            child: features[index],
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Botão sair
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF9B0036),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _logout,
                      icon: const Icon(Icons.logout, color: Colors.white),
                      label: const Text(
                        'SAIR',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
