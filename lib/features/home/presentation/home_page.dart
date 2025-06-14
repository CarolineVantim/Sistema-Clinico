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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('username');
              Navigator.pushReplacementNamed(context, Routes.login);
            },
            child: const Text('SAIR'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        children: [
          Card.outlined(
            color: const Color(0xFF257A9F),
            margin: const EdgeInsets.fromLTRB(4, 16, 4, 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        alignment: Alignment.center),
                    FutureBuilder<SharedPreferences>(
                      future: SharedPreferences.getInstance(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          String userName =
                              snapshot.data?.getString('username') ?? 'Usuário';
                          return Text(
                            'Olá, $userName',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(color: Colors.white60),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 0, 20.0),
                        child: Text(
                          'Bem-vindo ao seu Dashboard',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: Colors.white60),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: Align(
                    alignment: const Alignment(0, 0),
                    child: Text(
                      'NAVEGUE POR',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                    ),
                    itemCount: features.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, features[index].route);
                        },
                        child: features[index],
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
