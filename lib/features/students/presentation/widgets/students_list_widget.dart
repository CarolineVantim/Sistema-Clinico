import 'package:flutter/material.dart';
import 'package:sistema_clinico/shared/data/models/student.dart';
import 'package:sistema_clinico/shared/widgets/not_found_widget.dart';
import 'student_simple_card.dart';

class StudentsListWidget extends StatelessWidget {
  const StudentsListWidget({
    super.key,
    required this.students,
  });

  final List<Student> students;

  @override
  Widget build(BuildContext context) {
    if (students.isEmpty) {
      return const NotFoundCard(text: 'Vazio');
    }

    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, index) => StudentSimpleCard(
        student: students[index],
      ),
    );
  }
}
