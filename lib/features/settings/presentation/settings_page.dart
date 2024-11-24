import 'package:flutter/material.dart';
import 'package:sistema_clinico/shared/utils/theme.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPage createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  int _selectedIndex = 0;
  String searchText = "";

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Troca de tema',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 10),
            Switch(
              value: ThemeChange.instance.isDartTheme,
              onChanged: (value) {
                ThemeChange.instance.changeTheme();
              },
            ),
          ],
        ),
      ),
    );
  }
}
