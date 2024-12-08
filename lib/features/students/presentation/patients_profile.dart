import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sistema_clinico/features/treatment/presentation/service_detail_page.dart';
import 'package:sistema_clinico/shared/data/models/class_records_model.dart';
import 'package:sistema_clinico/features/students/data/repositories/class_records_repository_impl.dart';

class PatientsProfile extends ConsumerWidget {
  final String name;
  final String? studentImage; // Agora trata a imagem em base64
  final String cpf;

  const PatientsProfile({
    super.key,
    required this.name,
    this.studentImage, // Atualizando o parâmetro
    required this.cpf,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final atendimentosAsync = ref.watch(atendimentosPorCpfProvider(cpf));

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      studentImage != null && studentImage!.isNotEmpty
                          ? MemoryImage(base64Decode(
                              studentImage!)) // Tratando a imagem em base64
                          : null, // Caso não tenha imagem, não exibe nada
                  child: studentImage == null || studentImage!.isEmpty
                      ? Icon(
                          Icons.person, // Ícone padrão se não houver imagem
                          size: 60,
                          color: Colors.white,
                        )
                      : null,
                  backgroundColor: Colors.blue,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    name.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 28,
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
              child: atendimentosAsync.when(
                data: (atendimentos) => ListView.builder(
                  itemCount: atendimentos.length,
                  itemBuilder: (context, index) {
                    final atendimento = atendimentos[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(atendimento.subject ?? "Sem descrição"),
                        subtitle: Text(
                          atendimento.professional?.name ?? "Sem profissional",
                        ),
                        trailing: const Icon(Icons.arrow_forward),
                        leading: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            atendimento.classDate ?? "Data indisponível",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ServiceDetailPage(
                                title: atendimento.subject ?? "Detalhes",
                                description: atendimento.professional?.name ??
                                    "Sem descrição",
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stackTrace) => Center(
                  child: Text("Erro ao carregar dados: $error"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
