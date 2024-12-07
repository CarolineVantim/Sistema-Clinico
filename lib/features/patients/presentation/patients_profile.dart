import 'package:flutter/material.dart';

class PatientsProfile extends StatelessWidget {
  final String name;
  final IconData avatar;

  const PatientsProfile({
    super.key,
    required this.name,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> atendimentos = [
      {'date': "04/11/2024", 'description': "Atividade de Concentração", 'professional': "Eduardo - Pediatra"},
      {'date': "06/12/2024", 'description': "Textura de alimentos", 'professional': "Rosa - Nutricionista"},
      {'date': "06/12/2024", 'description': "Jogo da memoria", 'professional': "Thiago - Educador"},
      {'date': "06/12/2024", 'description': "Atividade de Concentraçãs", 'professional': "Maria - Pediatra"},
      {'date': "06/12/2024", 'description': "Textura de alimentos", 'professional': "Rosa - Nutricionista"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Paciente"),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 60, // Aumenta o tamanho do avatar
                  child: Icon(avatar, size: 60, color: Colors.white),
                  backgroundColor: Colors.blue,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    name.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 28, // Aumenta o tamanho do texto do nome
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "ATENDIMENTOS REALIZADOS",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: atendimentos.length,
                itemBuilder: (context, index) {
                  final atendimento = atendimentos[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(atendimento['description']!),
                      subtitle: Text(atendimento['professional']!),
                      trailing: const Icon(Icons.arrow_forward),
                      leading: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue, // Fundo azul
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          atendimento['date']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onTap: () {
                        // Aqui você pode adicionar uma ação ao clicar no atendimento.
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
