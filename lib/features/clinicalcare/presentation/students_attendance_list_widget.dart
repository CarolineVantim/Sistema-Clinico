import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sistema_clinico/features/students/domain/students_model.dart';

import '../../students/presentation/widgets/student_simple_card.dart';
import '../domain/clinical_care.dart';

class StudentsAttendanceListWidget extends StatelessWidget {
  const StudentsAttendanceListWidget({
    super.key,
    required this.clinicalCare,
    required this.student,
  });

  final StudentModel student;
  final List<ClinicalCare> clinicalCare;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
          child: StudentSimpleCard(student: student),
        )
      ],
    );
  }
}
