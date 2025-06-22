import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:sistema_clinico/shared/data/models/atendimento_model.dart';
import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final atendimentoProvider = AsyncNotifierProvider<AtendimentoNotifier, void>(
  AtendimentoNotifier.new,
);

class AtendimentoNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // Inicialização se necessário
  }

  Future<void> criarAtendimento(Atendimento atendimento) async {
    final String apiBaseUrl = dotenv.env['API_LINK']!;

    final url = Uri.parse('$apiBaseUrl/api/class_records/register');

    state = const AsyncLoading();
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(atendimento.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        state = const AsyncData(null);
      } else {
        final errorMessage =
            'Erro ao criar atendimento: Status ${response.statusCode}, Body: ${response.body}';
        throw Exception(errorMessage);
      }
    } catch (e, st) {
      state = AsyncError(e, st);
      print('Erro ao criar atendimento: $e');
    }
  }
}
