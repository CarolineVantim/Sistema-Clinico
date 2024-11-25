import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sistema_clinico/shared/widgets/not_found_widget.dart';
import '../../domain/students_model.dart';
import 'student_simple_card.dart';

class StudentsListWidget extends StatelessWidget {
  const StudentsListWidget({
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
      itemBuilder: (context, index) => StudentSimpleCard(
        student: students[index],
      ),
    );
  }
}
