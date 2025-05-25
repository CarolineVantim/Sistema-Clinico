import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sistema_clinico/features/students/domain/students_model.dart';

import '../../../clinicalcare/presentation/clinical_care_page.dart';

class StudentSimpleCard extends StatelessWidget {
  const StudentSimpleCard({super.key, required this.student});

  final StudentModel student;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ClinicalCarePage(student),
            ),
          );
        },
        leading: CircleAvatar(
          radius: 32,
          backgroundImage: MemoryImage(
            base64Decode(
              student.studentImage!,
            ),
          ),
        ),
        title: Text(
          student.name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(
          student.cpf,
          style: Theme.of(context).textTheme.bodyLarge,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
