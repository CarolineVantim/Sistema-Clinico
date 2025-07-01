import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sistema_clinico/features/appointments/presentation/new_appointment/new_appointment.dart';
import 'package:sistema_clinico/services/api_service.dart';
import 'package:sistema_clinico/shared/constants/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Appointments extends StatefulWidget {
  const Appointments({super.key});

  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agendamentos"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              ImageResourceEnum.building.path,
              height: 200,
              width: 200,
            ),
            const SizedBox(height: 20),
            const Text(
              'Esta tela está em construção!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const Text(
              'Em breve teremos mais novidades aqui.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
