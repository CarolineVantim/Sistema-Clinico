import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sistema_clinico/shared/constants/colors.dart';
// import 'package:sistema_clinico/services/api_service.dart';

class Appointments extends StatefulWidget {
  const Appointments({super.key});

  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  List<Map<String, dynamic>> appointments = [];
  List<Map<String, dynamic>> filteredAppointments = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();

    mockData();
  }

  void mockData() {
    setState(() {
      appointments = [
        {
          'id': 1,
          'professionalName': 'Maria Silva',
          'discipline': 'Psicologia',
          'classDate': '2025-06-01',
          'subject': 'Sessão de Avaliação',
        },
        {
          'id': 2,
          'professionalName': 'João Souza',
          'discipline': 'Fonoaudiologia',
          'classDate': '2025-06-02',
          'subject': 'Terapia de Fala',
        },
        {
          'id': 3,
          'professionalName': 'Ana Costa',
          'discipline': 'Psicopedagogia',
          'classDate': '2025-06-03',
          'subject': 'Acompanhamento Escolar',
        },
      ];
      filteredAppointments = appointments;
    });
  }

  /*
  Future<void> fetchAppointments() async {
    try {
      final response = await ApiClient().viewAllClass();

      if (response["statusCode"] == 200) {
        final List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(response['data']);

        setState(() {
          appointments = data.map((item) {
            return {
              'id': item['id'],
              'professionalName': item['professionalName'],
              'discipline': item['discipline'],
              'classDate': item['classDate'],
              'subject': item['subject'],
            };
          }).toList();
          filteredAppointments = appointments;
        });
      } else {
        throw Exception(
            'Erro ao buscar agendamentos: ${response["statusCode"]}');
      }
    } catch (e) {
      print('Erro ao buscar agendamentos: $e');
    }
  }
  */

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
      filteredAppointments = appointments
          .where((appointment) =>
              appointment['professionalName']
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()) ||
              appointment['subject']
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: tCardBgColor,
        elevation: 1,
        title: const Text(
          "AGENDA",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(12.0),
          //   child: TextField(
          //     decoration: InputDecoration(
          //       hintText: "Pesquisar por profissional ou assunto",
          //       prefixIcon: const Icon(Icons.search, color: Colors.grey),
          //       filled: true,
          //       fillColor: Colors.white,
          //       contentPadding:
          //           const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(12.0),
          //         borderSide: const BorderSide(color: Colors.transparent),
          //       ),
          //       enabledBorder: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(12.0),
          //         borderSide: const BorderSide(color: Colors.transparent),
          //       ),
          //       focusedBorder: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(12.0),
          //         borderSide: const BorderSide(color: Colors.blue),
          //       ),
          //     ),
          //     onChanged: updateSearchQuery,
          //   ),
          // ),
          Expanded(
            child: filteredAppointments.isEmpty
                ? const Center(child: Text("Nenhum agendamento encontrado."))
                : ListView.builder(
                    itemCount: filteredAppointments.length,
                    itemBuilder: (context, index) {
                      final appointment = filteredAppointments[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: CircleAvatar(
                                radius: 24,
                                backgroundColor: Colors.blue.shade600,
                                child: Text(
                                  appointment['discipline'][0].toUpperCase(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                              title: Text(
                                appointment['professionalName'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Disciplina: ${appointment['discipline']}",
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      "Data: ${appointment['classDate']}",
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      "Assunto: ${appointment['subject']}",
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          // Aqui você define a navegação para a tela de cadastro de atendimento.
          // Exemplo:
          // Navigator.push(context, MaterialPageRoute(builder: (context) => AddAppointmentScreen()));

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Ação de adicionar atendimento')),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
