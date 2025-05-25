import 'package:flutter/material.dart';
import 'package:sistema_clinico/shared/widgets/not_found_widget.dart';
import '../../domain/students_model.dart';
import 'student_professional_simple_card.dart';

class StudentsProfessionalListWidget extends StatelessWidget {
  const StudentsProfessionalListWidget({
    super.key,
    required this.students,
  });

  final List<StudentModel> students;

  @override
  Widget build(BuildContext context) {
    if (students.isEmpty) {
      return const NotFoundCard(text: 'Sem alunos cadastrados ainda!');
    }

    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, index) => StudentProfessionalSimpleCard(
        student: students[index],
      ),
    );
  }
}
