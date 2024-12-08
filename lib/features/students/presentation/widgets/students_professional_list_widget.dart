import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sistema_clinico/shared/data/models/student.dart';
import 'package:sistema_clinico/shared/widgets/not_found_widget.dart';
import 'student_professional_simple_card.dart';

class StudentsProfessionalListWidget extends StatelessWidget {
  const StudentsProfessionalListWidget({
    super.key,
    required this.students,
  });

  final List<Student> students;

  @override
  Widget build(BuildContext context) {
    if (students.isEmpty) {
      return const NotFoundCard(text: 'Sem pacientes cadastrados ainda!');
    }

    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, index) => StudentProfessionalSimpleCard(
        student: students[index],
      ),
    );
  }
}
