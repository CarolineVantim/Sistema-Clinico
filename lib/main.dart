import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sistema_clinico/features/appointments/presentation/appointments_page.dart';
import 'package:sistema_clinico/features/treatment/presentation/service_detail_page.dart';
import 'package:sistema_clinico/features/patients/presentation/patients_page.dart';
import 'package:sistema_clinico/features/patients/presentation/patients_page.dart';
import 'package:sistema_clinico/features/settings/presentation/settings_page.dart';
import 'package:sistema_clinico/features/home/presentation/home_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pipa App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        // '/treatment_description_page': (context) => const ServiceDetailPage(),
        '/student_parents': (context) => Patients(),
        '/patients': (context) => Patients(),
        '/appointments': (context) => Appointments(),
        '/settings_page': (context) => const SettingsPage(),
      },
    );
  }
}
