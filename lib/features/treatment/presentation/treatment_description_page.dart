import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sistema_clinico/shared/data/models/atendimento_model.dart';
import 'package:sistema_clinico/shared/data/providers/atendimento_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddService extends ConsumerStatefulWidget {
  const AddService({super.key});

  @override
  ConsumerState<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends ConsumerState<AddService> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _clientController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _professionalController =
      TextEditingController(); // Mantido
  final TextEditingController _descriptionController = TextEditingController();

  List<String> _clientSuggestions = [];
  // List<String> _professionalSuggestions = []; // REMOVIDO

  String? selectedCpf;
  String?
      selectedCrm; // Ainda mantemos para usar no modelo de Atendimento, mas o valor virá do campo de texto

  final List<String> materias = [
    'Fisioterapia',
    'Nutricionista',
    'Fonoaudiologa'
  ];
  String? _selectedMateria;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  String get formattedDateTime {
    if (_selectedDate == null || _selectedTime == null) {
      return '';
    }
    final date = DateFormat('dd/MM/yyyy').format(_selectedDate!);
    final time = _selectedTime!.format(context);
    return '$date $time';
  }

  Future<void> _pickDateTime(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: _selectedTime ?? TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDate = pickedDate;
          _selectedTime = pickedTime;
        });
      }
    }
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
    // _professionalSuggestions = []; // REMOVIDO
    setState(() {});
  }

  Future<void> _createLesson(WidgetRef ref) async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos obrigatórios')),
      );
      return;
    }

    // Ajuste: selectedCrm agora vem diretamente do _professionalController.text
    // O CPF ainda precisa ser selecionado, então o validador do cliente é mantido
    if (selectedCpf == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecione um cliente válido')),
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
      crm: _professionalController.text, // **CRM agora vem do texto digitado**
      mediaId: 0,
      studentCpf: selectedCpf!,
    );

    try {
      await ref
          .read(atendimentoProvider.notifier)
          .criarAtendimento(atendimento);
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

  // Future<List<String>> fetchProfissionais(String query) async { // REMOVIDO
  //   await Future.delayed(const Duration(milliseconds: 300));
  //   try {
  //     final String apiBaseUrl = dotenv.env['API_LINK']!;
  //     final response = await http.get(
  //       Uri.parse(
  //           '$apiBaseUrl/api/class_records/find_class_by_professional_crm?crm=$query'),
  //     );
  //     if (response.statusCode == 200) {
  //       final List data = jsonDecode(response.body);
  //       return data.map<String>((e) => e['crm'].toString()).toSet().toList();
  //     } else {
  //       return [];
  //     }
  //   } catch (e) {
  //     return [];
  //   }
  // }

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
              TextFormField(
                controller: _clientController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Cliente (CPF)',
                  hintText: 'Digite o CPF do cliente',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
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
              TextFormField(
                readOnly: true,
                controller: TextEditingController(text: formattedDateTime),
                decoration: const InputDecoration(
                  labelText: 'Data e Horário',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () => _pickDateTime(context),
                validator: (value) {
                  if (_selectedDate == null || _selectedTime == null) {
                    return 'Por favor, selecione a data e o horário.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Título do atendimento',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um título.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedMateria,
                decoration: const InputDecoration(
                  labelText: 'Profissão',
                  border: OutlineInputBorder(),
                ),
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
              // --- CAMPO PROFISSIONAL SIMPLIFICADO ---
              TextFormField(
                controller: _professionalController,
                decoration: const InputDecoration(
                  labelText: 'Registro do Profissional', // Alterado
                  hintText: 'Número de Registro do Profissional', // Adicionado
                  border: OutlineInputBorder(),
                  // prefixIcon: Icon(Icons.search), // REMOVIDO
                ),
                // onChanged: (query) async { ... } // REMOVIDO
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o registro do profissional.';
                  }
                  return null;
                },
              ),
              // if (_professionalSuggestions.isNotEmpty) // REMOVIDO
              //   Container( // REMOVIDO
              //     constraints: const BoxConstraints(maxHeight: 200), // REMOVIDO
              //     decoration: BoxDecoration( // REMOVIDO
              //       border: Border.all(color: Colors.grey), // REMOVIDO
              //       borderRadius: BorderRadius.circular(4.0), // REMOVIDO
              //     ), // REMOVIDO
              //     child: ListView.builder( // REMOVIDO
              //       shrinkWrap: true, // REMOVIDO
              //       itemCount: _professionalSuggestions.length, // REMOVIDO
              //       itemBuilder: (context, index) { // REMOVIDO
              //         final suggestion = _professionalSuggestions[index]; // REMOVIDO
              //         return ListTile( // REMOVIDO
              //           title: Text(suggestion), // REMOVIDO
              //           onTap: () { // REMOVIDO
              //             setState(() { // REMOVIDO
              //               _professionalController.text = suggestion; // REMOVIDO
              //               selectedCrm = suggestion; // REMOVIDO
              //               _professionalSuggestions = []; // REMOVIDO
              //             }); // REMOVIDO
              //             FocusScope.of(context).unfocus(); // REMOVIDO
              //           }, // REMOVIDO
              //         ); // REMOVIDO
              //       }, // REMOVIDO
              //     ), // REMOVIDO
              //   ), // REMOVIDO
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Observação',
                  helperText: 'Descrição completa do atendimento',
                  border: OutlineInputBorder(),
                ),
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
              if (asyncState is AsyncLoading)
                const CircularProgressIndicator()
              else
                Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: () => _createLesson(ref),
                        child: const Text('Salvar'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(color: Colors.red),
                        ),
                        child: const Text('Cancelar'),
                      ),
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
