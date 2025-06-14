import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sistema_clinico/features/appointments/presentation/new_appointment/new_appointment.dart';

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
    fetchAppointments();
  }

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
      appBar: AppBar(
        title: const Text("Agendamentos"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Pesquisar por profissional ou assunto",
                prefixIcon: const Icon(Icons.search, color: Colors.blue),
                filled: true,
                fillColor: Colors.blue.shade50,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: updateSearchQuery,
            ),
          ),
          Expanded(
            child: filteredAppointments.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: filteredAppointments.length,
                    itemBuilder: (context, index) {
                      final appointment = filteredAppointments[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text(
                                appointment['discipline'][0],
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.blue,
                            ),
                            title: Text(appointment['professionalName']),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "Disciplina: ${appointment['discipline']}"),
                                Text("Data: ${appointment['classDate']}"),
                                Text("Assunto: ${appointment['subject']}"),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
