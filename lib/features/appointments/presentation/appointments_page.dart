import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Appointments extends StatefulWidget {
  Appointments({super.key});

  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  final List<Map<String, String>> patients = [
    {'name': 'Marcos', 'date': '10/09/2024'},
    {'name': 'Alice', 'date': '12/09/2024'},
    {'name': 'Jennifer', 'date': '19/09/2024'},
    {'name': 'Enzo', 'date': '23/09/2024'},
  ];

  List<Map<String, String>> filteredPatients = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    filteredPatients = patients;
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
      filteredPatients = patients
          .where((patient) => patient['name']!
              .toLowerCase()
              .contains(searchQuery.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agendamentos"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Pesquisar paciente",
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
            child: ListView.builder(
              itemCount: filteredPatients.length,
              itemBuilder: (context, index) {
                final patient = filteredPatients[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      title: Text(patient['name']!),
                      subtitle: Text(patient['date']!),
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
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          //TODO: Fazer chamada para a tela de novo agendamento.
        },
      ),
    );
  }
}
