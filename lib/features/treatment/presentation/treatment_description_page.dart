import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sistema_clinico/shared/data/models/atendimento_model.dart';
import 'package:sistema_clinico/shared/data/providers/atendimento_provider.dart';
import 'package:sistema_clinico/shared/widgets/action_buttons.dart';
import 'package:sistema_clinico/shared/widgets/custom_dropdown_field.dart';
// Widgets
import 'package:sistema_clinico/shared/widgets/custom_text_form_field.dart';
import 'package:sistema_clinico/shared/widgets/date_time_picker_field.dart';

class AddService extends ConsumerStatefulWidget {
  const AddService({super.key});

  @override
  ConsumerState<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends ConsumerState<AddService> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _clientController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _professionalController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  List<String> _clientSuggestions = [];

  String? selectedCpf;
  String? selectedCrm;

  final List<String> materias = [
    'Fisioterapia',
    'Nutricionista',
    'Fonoaudiologa'
  ];
  String? _selectedMateria;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void dispose() {
    _clientController.dispose();
    _titleController.dispose();
    _professionalController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _clientController.clear();
    _titleController.clear();
    _professionalController.clear();
    _descriptionController.clear();
    selectedCpf = null;
    selectedCrm = null;
    _selectedMateria = null;
    _selectedDate = null;
    _selectedTime = null;
    _clientSuggestions = [];
    setState(() {});
  }

  Future<void> _createLesson() async {
    if (!_formKey.currentState!.validate()) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos obrigatórios')),
      );
      return;
    }

    if (selectedCpf == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecione um cliente válido')),
      );
      return;
    }

    if (_selectedDate == null || _selectedTime == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Por favor, selecione a data e o horário.')),
      );
      return;
    }

    final dateTime = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );

    final atendimento = Atendimento(
      classDate: DateFormat('yyyy-MM-dd').format(dateTime),
      startTime: DateFormat('HH:mm:ss').format(dateTime),
      endTime:
          DateFormat('HH:mm:ss').format(dateTime.add(const Duration(hours: 1))),
      subject: _titleController.text,
      status: 'planned',
      discipline: _selectedMateria!,
      location: 'Sala 1',
      notes: [_descriptionController.text],
      crm: _professionalController.text,
      mediaId: 0,
      studentCpf: selectedCpf!,
    );

    try {
      await ref
          .read(atendimentoProvider.notifier)
          .criarAtendimento(atendimento);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Atendimento criado com sucesso!')),
      );
      _resetForm();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao criar atendimento: $e')),
      );
    }
  }

  Future<List<String>> fetchClientes(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      final String apiBaseUrl = dotenv.env['API_LINK']!;

      final response = await http.get(
        Uri.parse('$apiBaseUrl/student/find_by?cpf=$query'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> dataList = jsonDecode(response.body);

        if (dataList.isNotEmpty) {
          final Map<String, dynamic> firstStudent = dataList.first;
          if (firstStudent.containsKey('cpf')) {
            return [firstStudent['cpf'].toString()];
          }
        }
        return [];
      } else if (response.statusCode == 404) {
        print('CPF não encontrado: ${response.statusCode}');
        return [];
      } else {
        print(
            'Erro na API ao buscar cliente: ${response.statusCode} - ${response.body}');
        return [];
      }
    } catch (e) {
      print('Erro de rede/parsing ao buscar cliente: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(atendimentoProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Atendimento'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormField(
                controller: _clientController,
                keyboardType: TextInputType.number,
                labelText: 'Cliente (CPF)',
                hintText: 'Digite o CPF do cliente',
                prefixIcon: const Icon(Icons.search),
                onChanged: (query) async {
                  if (query.isNotEmpty && query.length >= 3) {
                    final suggestions = await fetchClientes(query);
                    setState(() {
                      _clientSuggestions = suggestions;
                    });
                  } else {
                    setState(() {
                      _clientSuggestions = [];
                    });
                  }
                  selectedCpf = null;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o CPF do cliente.';
                  }
                  if (selectedCpf == null || selectedCpf != value) {
                    return 'CPF não encontrado ou não selecionado.';
                  }
                  return null;
                },
              ),
              if (_clientSuggestions.isNotEmpty)
                Container(
                  constraints: const BoxConstraints(maxHeight: 200),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _clientSuggestions.length,
                    itemBuilder: (context, index) {
                      final suggestion = _clientSuggestions[index];
                      return ListTile(
                        title: Text(suggestion),
                        onTap: () {
                          setState(() {
                            _clientController.text = suggestion;
                            selectedCpf = suggestion;
                            _clientSuggestions = [];
                          });
                          FocusScope.of(context).unfocus();
                        },
                      );
                    },
                  ),
                ),
              const SizedBox(height: 16),
              DateTimePickerField(
                labelText: 'Data e Horário',
                initialDate: _selectedDate,
                initialTime: _selectedTime,
                onDateSelected: (date) {
                  setState(() {
                    _selectedDate = date;
                  });
                },
                onTimeSelected: (time) {
                  setState(() {
                    _selectedTime = time;
                  });
                },
                validator: (value) {
                  if (_selectedDate == null || _selectedTime == null) {
                    return 'Por favor, selecione a data e o horário.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: _titleController,
                labelText: 'Título do atendimento',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um título.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomDropdownField<String>(
                value: _selectedMateria,
                labelText: 'Profissão',
                onChanged: (value) => setState(() => _selectedMateria = value),
                items: materias
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, selecione uma profissão.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: _professionalController,
                labelText: 'Registro do Profissional',
                hintText: 'Número de Registro do Profissional',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o registro do profissional.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: _descriptionController,
                labelText: 'Observação',
                hintText: 'Descrição completa do atendimento',
                maxLines: 4,
              ),
              const SizedBox(height: 24),
              FilledButton.tonal(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Funcionalidade em breve!')),
                  );
                },
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
                child: const Text("Anexar Imagem/Vídeo"),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  PrimaryButton(
                    text: 'Salvar',
                    onPressed: () async {
                      await _createLesson();
                    },
                    isLoading: asyncState is AsyncLoading,
                  ),
                  const SizedBox(width: 16),
                  SecondaryButton(
                    text: 'Cancelar',
                    onPressed: () => Navigator.pop(context),
                    foregroundColor: Colors.red,
                    borderColor: Colors.red,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
