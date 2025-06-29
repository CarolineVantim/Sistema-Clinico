// shared/data/providers/atendimento_provider.dart
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:sistema_clinico/shared/data/models/atendimento_model.dart';
import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';

final atendimentoProvider = AsyncNotifierProvider<AtendimentoNotifier, void>(
  AtendimentoNotifier.new,
);

class AtendimentoNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // Inicialização se necessário
  }

  Future<int?> uploadMedia(XFile mediaFile) async {
    final String apiBaseUrl = dotenv.env['API_LINK']!;
    final url = Uri.parse('$apiBaseUrl/video_records/upload');

    state = const AsyncLoading();
    try {
      var request = http.MultipartRequest('POST', url);

      request.files.add(await http.MultipartFile.fromPath(
        'media',
        mediaFile.path,
        filename: mediaFile.name,
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final int? mediaId = data['media_id'];
        if (mediaId != null) {
          state = const AsyncData(null);
          return mediaId;
        } else {
          throw Exception('Backend não retornou media_id após upload.');
        }
      } else {
        final errorMessage =
            'Erro ao fazer upload da mídia: Status ${response.statusCode}, Body: ${response.body}';
        throw Exception(errorMessage);
      }
    } catch (e, st) {
      state = AsyncError(e, st);
      print('Erro ao fazer upload da mídia: $e');
      rethrow; // Relança o erro para ser tratado na UI
    }
  }

  Future<void> criarAtendimento(Atendimento atendimento) async {
    final String apiBaseUrl = dotenv.env['API_LINK']!;
    final url = Uri.parse('$apiBaseUrl/class_records/register');

    state =
        const AsyncLoading(); // Estado de carregamento para a criação do atendimento
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
