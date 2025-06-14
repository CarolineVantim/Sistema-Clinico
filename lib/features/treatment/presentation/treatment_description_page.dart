import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddService extends StatefulWidget {
  const AddService({super.key});

  @override
  _AddServiceState createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  List<String> materias = [
    'Fonoaudiólogo(a)',
    'Nutricionista',
    'Psicólogo(a)',
    'Assistente Sociai',
    'Fisioterapeuta',
  ];
  String? _selectedMateria;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _pickDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: _selectedTime ?? TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          _selectedDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          _selectedTime = pickedTime;
        });
      }
    }
  }

  Future<void> _createLesson() async {
    //TODO: Itegrar com API
    var url = Uri.parse('https://yourapi.com/lessons');

    //TODO: Substituir pelo DioProvider
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'title': _titleController.text,
        'description': _descriptionController.text,
        'materia': _selectedMateria,
        'date': _selectedDate?.toIso8601String(),
      }),
    );
    if (response.statusCode == 200) {
      Navigator.pop(context);
    } else {
      // Handle error
      print('Failed to create lesson: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NOVO ATENDIMENTO'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 20),
              Row(
                children: [
                  Flexible(
                    child: TextFormField(
                        decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      // hintText: 'Busca',
                      labelText: 'Pesquisar',
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: Icon(Icons.cancel), helperText: 'Pacientes',
                    )),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Flexible(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        // hintText: 'Data',
                        label: Text('Data'),
                        suffixIcon: Icon(Icons.calendar_today),
                        helperText: 'MM/DD/AAAA',
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                      // label: Text("Título"),
                      // hintText: "Informe o título do atendimento",
                      labelText: 'Título',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(color: Colors.blue),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      suffixIcon: Icon(Icons.cancel)),
                ),
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Profissão',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.blue),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                value: _selectedMateria,
                hint: const Text("Profissão"),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedMateria = newValue;
                  });
                },
                items: materias.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                      // label: Text("Título"),
                      // hintText: "Informe o título do atendimento",
                      labelText: 'Profissional',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(color: Colors.blue),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      suffixIcon: Icon(Icons.cancel)),
                ),
              ),
              // const SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: () => _pickDateTime(context),
              //   child: Text(_selectedDate == null
              //       ? 'Escolher Data e Hora'
              //       : '${DateFormat('dd/MM/yyyy').format(_selectedDate!)} ${_selectedTime!.format(context)}'),
              // ),
              // const SizedBox(height: 20),
              // const SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: "Observação",
                  helperText: 'Descrição completa do atendimento',
                  // hintText: "Conte um pouco sobre o atendimento",
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.blue),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                minLines: 3,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: SizedBox(
                  height: 48,
                  width: double.maxFinite,
                  child: FilledButton.tonal(
                    onPressed: _createLesson,
                    // style: ElevatedButton.styleFrom(
                    //   foregroundColor: Colors.white,
                    //   backgroundColor: Colors.blue,
                    // ),
                    child: const Text("ANEXAR ARQUIVO"),
                  ),
                ),
              ),
              // const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: SizedBox(height: 48,
                      child: FilledButton(
                        onPressed: _createLesson,
                        style: ElevatedButton.styleFrom(
                          // foregroundColor: Colors.white,
                          // backgroundColor: Colors.blue,
                        ),
                        child: const Text("SALVAR"),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          // foregroundColor: Colors.blue,
                          // backgroundColor: Colors.white,
                          side: const BorderSide(color: Colors.blue),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: const Text("CANCELAR"),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
