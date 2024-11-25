import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Patients extends StatefulWidget {
  const Patients({super.key});

  @override
  _PatientsState createState() => _PatientsState();
}

class _PatientsState extends State<Patients> {
  final List<Map<String, dynamic>> patients = [
    {'name': 'Marcos', 'age': '4 anos', 'avatar': Icons.child_care},
    {'name': 'Maria Clara', 'age': '3 anos', 'avatar': Icons.face},
    {'name': 'João Vitor', 'age': '7 anos', 'avatar': Icons.child_care},
    {'name': 'Marcos', 'age': '4 anos', 'avatar': Icons.child_care},
  ];

  List<Map<String, dynamic>> filteredPatients = [];
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
        title: const Text("Pacientes"),
        leading: IconButton(
          onPressed: () => {},
          icon: const Icon(Icons.arrow_back),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              child: Text(
                "M",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Pesquisar paciente",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
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
                    color: Colors.white, // Alterado para branco
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Icon(
                          patient['avatar'],
                          color: Colors.blue,
                        ),
                      ),
                      title: Text(patient['name']!),
                      subtitle: Text(patient['age']!),
                      trailing: IconButton(
                        icon: const Icon(Icons.notes),
                        onPressed: () {
                          print("teste");
                        },
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
