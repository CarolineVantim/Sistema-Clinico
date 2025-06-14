import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sistema_clinico/shared/widgets/search_bar.dart' as custom;
import 'package:sistema_clinico/shared/widgets/loading_widgets.dart';
import 'package:sistema_clinico/features/students/data/repositories/students_professional_repository_impl.dart';
import 'widgets/students_professional_list_widget.dart';

class StudentsPageProfessional extends ConsumerStatefulWidget {
  const StudentsPageProfessional({super.key});

  @override
  _StudentsPageProfessionalState createState() =>
      _StudentsPageProfessionalState();
}

class _StudentsPageProfessionalState
    extends ConsumerState<StudentsPageProfessional> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    final students = ref.watch(studentsprofessionalProvider(searchText));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pacientes'),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: custom.SearchBar(onSearch: (query) {
                    setState(() {
                      searchText = query;
                    });
                  }),
                ),
              ],
            ),
          ),
          Expanded(
            child: students.when(
              data: (data) {
                return StudentsProfessionalListWidget(students: data);
              },
              error: (error, stackTrace) => Text('Erro: $error'),
              loading: () => const LoadingWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
