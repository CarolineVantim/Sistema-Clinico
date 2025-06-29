import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sistema_clinico/shared/data/models/class_records_model.dart';
import 'package:sistema_clinico/shared/data/providers/dio_provider.dart';

class ClassRecordsRepository {
  final Dio dio;

  ClassRecordsRepository({required this.dio});

  // Método para buscar atendimentos por CPF
  Future<List<ClassRecordsModel>> fetchClassRecordsByCpf(String cpf) async {
    try {
      final response = await dio.get(
          '/class_records/find_class_by_student_cpf?page=0&studentCpf=$cpf');

      return [
        for (final json in response.data) ClassRecordsModel.fromJson(json)
      ];
    } on DioException catch (e) {
      throw Exception(
          'Erro ao buscar registros de atendimento: ${e.response?.data ?? e.message}');
    }
  }
}

// Provedor do repositório
final classRecordsRepositoryProvider = Provider<ClassRecordsRepository>((ref) {
  return ClassRecordsRepository(dio: ref.watch(dioProvider));
});

// Provedor para acessar atendimentos
final atendimentosPorCpfProvider =
    FutureProvider.family<List<ClassRecordsModel>, String>((ref, cpf) async {
  return ref.watch(classRecordsRepositoryProvider).fetchClassRecordsByCpf(cpf);
});
