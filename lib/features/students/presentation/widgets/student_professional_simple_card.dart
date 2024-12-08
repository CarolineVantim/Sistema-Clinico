import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sistema_clinico/shared/constants/constants.dart';
import 'package:sistema_clinico/features/students/domain/students_model.dart';

import 'package:sistema_clinico/features/clinicalcare/presentation/clinical_professional_care_page.dart';
import 'package:sistema_clinico/shared/data/models/student.dart';

class StudentProfessionalSimpleCard extends StatelessWidget {
  const StudentProfessionalSimpleCard({super.key, required this.student});

  final Student student;

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
