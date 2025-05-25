import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sistema_clinico/shared/constants/colors.dart';

class AddService extends StatefulWidget {
  const AddService({super.key});

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  final TextEditingController _clientController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _professionalController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Dados estáticos
  List<String> professions = [
    'Psicólogo',
    'Fonoaudiólogo',
    'Terapeuta Ocupacional',
    'Psicopedagogo'
  ];
  String? selectedProfession;
  DateTime? selectedDate;

  // Anexos
  List<XFile> attachments = [];
  final ImagePicker _picker = ImagePicker();

  // 📅 Selecionar data
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // 🖼️ Anexar imagem
  Future<void> pickMedia() async {
    final List<XFile>? picked = await _picker.pickMultiImage();

    if (picked != null) {
      setState(() {
        attachments.addAll(picked);
      });
    }
  }

  // 🚀 Simular envio
  void submitForm() {
    if (_clientController.text.isEmpty ||
        selectedDate == null ||
        _titleController.text.isEmpty ||
        selectedProfession == null ||
        _professionalController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos obrigatórios')),
      );
      return;
    }

    // Apenas simula sucesso
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Atendimento criado com sucesso (Offline)')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final dateFormatted = selectedDate != null
        ? DateFormat('dd/MM/yyyy').format(selectedDate!)
        : 'DD/MM/YYYY';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: tCardBgColor,
        title: const Text('NOVO ATENDIMENTO'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 50),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    controller: _clientController,
                    decoration: const InputDecoration(
                      labelText: 'Cliente',
                      suffixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: _selectDate,
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Data',
                        border: OutlineInputBorder(),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(dateFormatted),
                          const Icon(Icons.calendar_today),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Título',
                hintText: 'Título do atendimento',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            DropdownButtonFormField<String>(
              value: selectedProfession,
              decoration: const InputDecoration(
                labelText: 'Profissão',
                border: OutlineInputBorder(),
              ),
              items: professions
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedProfession = value;
                });
              },
            ),
            const SizedBox(height: 30),
            TextFormField(
              controller: _professionalController,
              decoration: const InputDecoration(
                labelText: 'Profissional',
                hintText: 'Nome do profissional',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            TextFormField(
              controller: _descriptionController,
              minLines: 3,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Observação',
                hintText: 'Descrição completa do atendimento',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: pickMedia,
              icon: const Icon(Icons.attach_file),
              label: const Text('Anexar Imagem'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey.shade100,
                foregroundColor: Colors.black,
              ),
            ),
            if (attachments.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Wrap(
                  spacing: 8,
                  children: attachments
                      .map(
                        (file) => Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Image.file(
                              File(file.path),
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  attachments.remove(file);
                                });
                              },
                              child: const CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.red,
                                child: Icon(Icons.close, size: 12),
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade300,
                minimumSize: const Size(120, 40),
              ),
              child: const Text('Salvar'),
            ),
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
                minimumSize: const Size(120, 40),
              ),
              child: const Text('Cancelar'),
            ),
          ],
        ),
      ),
    );
  }
}
