import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sistema_clinico/features/login/presentation/login_page.dart';
import 'package:sistema_clinico/features/home/presentation/home_page.dart';
import 'package:sistema_clinico/features/students/presentation/students_page.dart';
import 'package:sistema_clinico/features/treatment/presentation/treatment_description_page.dart';
import 'package:sistema_clinico/features/patients/presentation/patients_page.dart';
import 'package:sistema_clinico/features/appointments/presentation/appointments_page.dart';
import 'package:sistema_clinico/features/settings/presentation/settings_page.dart';
import 'package:sistema_clinico/features/treatment/presentation/service_detail_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Garante a inicialização correta
  await dotenv.load(); // Carrega o arquivo .env
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sistema Clínico',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.home, // Define a rota inicial como uma constante
      routes: {
        Routes.login: (context) => const LoginPage(),
        Routes.home: (context) => const HomePage(),
        Routes.students: (context) => const StudentsPage(),
        Routes.treatmentDescription: (context) => const AddService(),
        Routes.patients: (context) => const Patients(),
        Routes.appointments: (context) => Appointments(),
        Routes.settings: (context) => const SettingsPage(),
        Routes.appointment: (context) => const AddService(),
        // Routes.profile: (context) => const ProfilePage(),
        Routes.serviceDetail: (context) => const ServiceDetailPage(
            title: 'Título',
            description:
                'Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet. '),
      },
    );
  }
}

// Classe para gerenciar rotas nomeadas
class Routes {
  static const String login = '/login';
  static const String home = '/home';
  static const String students = '/students';
  static const String treatmentDescription = '/treatment_description';
  static const String patients = '/patients';
  static const String appointments = '/appointments';
  static const String settings = '/settings';
  static const String appointment = '/appointment';
  static const String profile = '/profile';
  static const String serviceDetail = '/service_detail';
}
