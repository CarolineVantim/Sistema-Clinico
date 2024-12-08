import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sistema_clinico/shared/widgets/loading_widgets.dart';
import 'package:sistema_clinico/features/students/data/repositories/students_repository_impl.dart';
import 'widgets/students_list_widget.dart';

class StudentsPage extends ConsumerWidget {
  const StudentsPage({super.key});

  //TODO: Definir a forma de filtro de pais

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var students = ref.watch(studentsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filhos'),
      ),
      body: students.when(
        data: (data) => StudentsListWidget(students: data),
        error: (error, stackTrace) => Text(stackTrace.toString()),
        loading: () => const LoadingWidget(),
      ),
    );
  }
}
