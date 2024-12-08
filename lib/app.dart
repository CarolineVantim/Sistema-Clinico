import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sistema_clinico/features/settings/presentation/settings_page.dart';
import 'package:sistema_clinico/features/appointments/presentation/appointments_page.dart';
import 'package:sistema_clinico/features/patients/presentation/patients_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistema_clinico/features/home/presentation/home_page.dart';
import 'package:sistema_clinico/features/treatment/presentation/service_detail_page.dart';
import 'package:sistema_clinico/features/treatment/presentation/treatment_description_page.dart';
import 'package:sistema_clinico/shared/utils/theme.dart';

final isDarkTheme = StateProvider((ref) => true);

final lightTheme = ThemeData(
  primarySwatch: Colors.blue,
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(color: Colors.blue),
);

final darkTheme = ThemeData(
  primarySwatch: Colors.blue,
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(color: Colors.blueGrey),
);

class App extends ConsumerWidget {
  const App({super.key});

  Future<bool> _checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('token');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedBuilder(
      animation: ThemeChange.instance,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Pipa App',
          theme: ref.watch(isDarkTheme) ? darkTheme : lightTheme,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('pt', 'BR'),
          ],
          routes: {
            '/': (context) => const ServiceDetailPage(
                title: 'Título',
                description:
                    'Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet. '),
            '/home': (context) => const HomePage(),
            '/patients': (context) => const Patients(),
            '/appointments': (context) => Appointments(),
            '/settings_page': (context) => const SettingsPage(),
          },
        );
      },
    );
  }
}
