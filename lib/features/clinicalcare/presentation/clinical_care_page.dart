import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sistema_clinico/features/clinicalcare/data/clinical_care_repository_impl.dart';
import 'package:sistema_clinico/features/clinicalcare/data/clinical_care_repository_position_impl.dart';
import 'package:sistema_clinico/features/clinicalcare/data/clinical_care_repository_date_impl.dart';
import 'package:sistema_clinico/features/clinicalcare/data/clinical_care_repository_date_position_impl.dart';
import 'package:sistema_clinico/shared/data/models/student.dart';

import 'package:sistema_clinico/shared/widgets/loading_widgets.dart';
import 'students_attendance_list_widget.dart';
import 'widgets/filterDateDropdown.dart';

class ClinicalCarePage extends ConsumerStatefulWidget {
  const ClinicalCarePage(this.student, {super.key});

  final Student student;

  @override
  _ClinicalCarePageState createState() => _ClinicalCarePageState();
}

class _ClinicalCarePageState extends ConsumerState<ClinicalCarePage> {
  String? _selectedDate;
  final String _selectedItem = '0';
  bool _isDropdownOpen = false;

  @override
  void initState() {
    super.initState();
    // Resetar filtros ao abrir a página
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(selectedDateProvider.notifier).state = null;
      ref.read(selectedItemProvider.notifier).state = '0';
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = ref.watch(selectedDateProvider);
    final selectedItem = ref.watch(selectedItemProvider);

    final clinicalProvider = selectedDate == null && selectedItem == '0'
        ? clinicalCareByStudentCpfProvider(widget.student.cpf)
        : selectedDate != null && selectedItem == '0'
            ? clinicalCareByDateProvider(widget.student.cpf, selectedDate)
            : selectedItem != '0'
                ? clinicalCareByPositionProvider(
                    widget.student.cpf, selectedItem)
                : clinicalCareByDatePositionProvider(
                    widget.student.cpf, selectedDate ?? '', selectedItem);

    final clinical = ref.watch(clinicalProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Paciente'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              setState(() {
                _isDropdownOpen = !_isDropdownOpen;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (_isDropdownOpen)
            FilterDateDropdown(
              onDateChanged: (date) {
                ref.read(selectedDateProvider.notifier).state = date;
              },
              onItemChanged: (item) {
                ref.read(selectedItemProvider.notifier).state = item;
              },
              onClearFilter: () {
                ref.read(selectedDateProvider.notifier).state = null;
                ref.read(selectedItemProvider.notifier).state = '0';
                setState(() {
                  _isDropdownOpen = false;
                });
              },
            ),
          Expanded(
            child: clinical.when(
              data: (data) => StudentsAttendanceListWidget(
                student: widget.student,
                clinicalCare: data,
              ),
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => const LoadingWidget(),
            ),
          ),
        ],
      ),
    );
  }
}

final selectedDateProvider = StateProvider<String?>((ref) => null);
final selectedItemProvider = StateProvider<String>((ref) => '0');
