import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sistema_clinico/shared/data/models/student.dart'; // Verifique se esse é o arquivo correto

import '../../students/presentation/patients_profile.dart';
import '../../students/presentation/widgets/student_simple_card.dart';
import '../domain/clinical_care.dart';

class StudentsAttendanceListWidget extends StatelessWidget {
  const StudentsAttendanceListWidget({
    super.key,
    required this.student,
    required this.clinicalCare,
  });

  final Student student;
  final List<ClinicalCare> clinicalCare;

  @override
  Widget build(BuildContext context) {
    return PatientsProfile(
      studentImage: student.studentImage,
      name: student.name,
      cpf: student.cpf,
    );
  }
}
