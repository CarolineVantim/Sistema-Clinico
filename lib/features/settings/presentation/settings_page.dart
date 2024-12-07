import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_clinico/shared/utils/theme.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<ThemeChange>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Troca de tema',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 10),
            Switch(
              value: themeChange.isDarkTheme,
              onChanged: (value) {
                themeChange.changeTheme();
              },
            ),
          ],
        ),
      ),
    );
  }
}
