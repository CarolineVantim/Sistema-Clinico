import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sistema_clinico/services/api_service.dart';
import 'patients_profile.dart';

class Patients extends StatefulWidget {
  const Patients({super.key});

  @override
  _PatientsState createState() => _PatientsState();
}

class _PatientsState extends State<Patients> {
  List<Map<String, dynamic>> patients = [];
  List<Map<String, dynamic>> filteredPatients = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    fetchPatients();
  }

  // Função para buscar dados da API
  Future<void> fetchPatients() async {
    try {
      final response = await ApiClient().viewAllP();
      if (response['statusCode'] == 200) {
        final List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(response['data']);
        setState(() {
          patients = data.map((patient) {
            return {
              'cpf': patient['cpf'],
              'name': patient['name'],
              'disabilityType': patient['disabilityType'],
              'birthDate': patient['birthDate'],
              'studentImage': patient['studentImage'],
            };
          }).toList();
          filteredPatients = patients;
        });
      } else {
        throw Exception('Erro ao buscar dados: ${response["statusCode"]}');
      }
    } catch (e) {
      print('Erro ao buscar dados: $e');
    }
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
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: patient['studentImage'] != ""
                            ? MemoryImage(base64Decode(patient['studentImage']))
                            : null,
                        child: patient['studentImage'] == ""
                            ? const Icon(Icons.person, color: Colors.grey)
                            : null,
                      ),
                      title: Text(patient['name']!),
                      subtitle: Text(patient['disabilityType']!),
                      trailing: IconButton(
                        icon: const Icon(Icons.notes),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PatientsProfile(
                                name: patient['name']!,
                                avatar: Icons.person,
                              ),
                            ),
                          );
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
