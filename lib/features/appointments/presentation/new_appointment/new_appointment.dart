import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sistema_clinico/services/api_service.dart';

class NewAppointmentScreen extends StatefulWidget {
  @override
  _NewAppointmentScreenState createState() => _NewAppointmentScreenState();
}

class _NewAppointmentScreenState extends State<NewAppointmentScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _observationController = TextEditingController();
  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _startHourController = TextEditingController();
  final TextEditingController _endHourController = TextEditingController();
  final List<File> images = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _addImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        final file = File(pickedFile.path);
        setState(() {
          if (images.length < 5) {
            images.add(file);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Você pode adicionar no máximo 5 imagens."),
              ),
            );
          }
        });
      }
    } catch (e) {
      print("Erro ao selecionar imagem: $e");
    }
  }

  void _sendData() async {
    if (_titleController.text.isEmpty ||
        _observationController.text.isEmpty ||
        _dayController.text.isEmpty ||
        _startHourController.text.isEmpty ||
        _endHourController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Por favor, preencha todos os campos obrigatórios.")),
      );
      return;
    }

    List<int> imageIds = [];

    for (var image in images) {
      try {
        final bytes = await image.readAsBytes();
        final base64Image = base64Encode(bytes);

        final response = await ApiClient().uploadImage(base64Image);
        imageIds.add(response["data"]["id"]);
      } catch (e) {
        print("Erro ao enviar imagem: $e");
      }
    }

    final professionalCrm = 12345;
    final studentCpf = 12345678901;
    final startTime = _startHourController.text;
    final endTime = _endHourController.text;
    final subject = _titleController.text;
    final status = "planned";
    final location = "string";
    final discipline = "string";

    var classDate = _dayController.text;
    try {
      classDate = convertDateToIsoFormat(classDate);
      print("Data convertida: $classDate");
    } catch (e) {
      print("Erro ao converter data: $e");
    }

    try {
      final response = await ApiClient().registerClassRecord(
          professionalCrm,
          studentCpf,
          imageIds,
          classDate,
          startTime,
          endTime,
          subject,
          status,
          location,
          discipline);

      print("Resposta do servidor: $response");
    } catch (e) {
      print("Erro ao registrar a aula: $e");
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Dados enviados com sucesso!")),
    );

    Navigator.popUntil(context, (route) => route.isFirst);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (selectedDate != null) {
      setState(() {
        _dayController.text =
            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
      });
    }
  }

  Future<void> _selectTime(
      BuildContext context, TextEditingController controller) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) {
      setState(() {
        controller.text = selectedTime.format(context);
      });
    }
  }

  String convertDateToIsoFormat(String date) {
    final parts = date.split('/');
    if (parts.length == 3) {
      final day = parts[0].padLeft(2, '0');
      final month = parts[1].padLeft(2, '0');
      final year = parts[2];

      return '$year-$month-$day';
    } else {
      throw FormatException("Data inválida: $date");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo Atendimento"),
        leading: IconButton(
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: TextField(
                          controller: _dayController,
                          decoration: const InputDecoration(
                            labelText: "Dia",
                            hintText: "DD/MM/AAAA",
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectTime(context, _startHourController),
                      child: AbsorbPointer(
                        child: TextField(
                          controller: _startHourController,
                          decoration: const InputDecoration(
                            labelText: "Hora Início",
                            hintText: "HH:MM",
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectTime(context, _endHourController),
                      child: AbsorbPointer(
                        child: TextField(
                          controller: _endHourController,
                          decoration: const InputDecoration(
                            labelText: "Hora Fim",
                            hintText: "HH:MM",
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length + (images.length < 5 ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == images.length) {
                      return GestureDetector(
                        onTap: _addImage,
                        child: Container(
                          width: 100,
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(color: Colors.blue),
                          ),
                          child: const Center(
                            child:
                                Icon(Icons.add, color: Colors.blue, size: 30),
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        width: 100,
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.file(
                            images[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "Título",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _observationController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Observação",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _sendData,
                child: const Text("Salvar"),
              ),
              const SizedBox(height: 16.0),
              OutlinedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text("CANCELAR"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
