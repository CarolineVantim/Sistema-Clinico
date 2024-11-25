import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sistema_clinico/shared/data/providers/dio_provider.dart';
import 'package:sistema_clinico/features/clinicalcare/domain/clinical_care.dart';
import 'package:sistema_clinico/features/clinicalcare/domain/clinical_care_position_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'clinical_care_repository_position_impl.g.dart';

class ClinicalCareRepositoryImpl implements ClinicalCarePositionRepository {
  final Dio dio;

  ClinicalCareRepositoryImpl({required this.dio});

  @override
  Future<List<ClinicalCare>> findAllByStudentCpf(
      String cpf, String position) async {
    var response = await dio.get(
        '/api/class_records/find_class_by_professional_position?studentCpf=$cpf&position=$position');
    return [for (final cc in response.data as List) ClinicalCare.fromJson(cc)];
  }
}

@riverpod
ClinicalCarePositionRepository clinicalcarepositionRepository(Ref ref) {
  return ClinicalCareRepositoryImpl(dio: ref.watch(dioProvider));
}

@riverpod
Future<List<ClinicalCare>> clinicalCareByPosition(
    Ref ref, String cpf, String position) async {
  return await ref
      .watch(clinicalcarepositionRepositoryProvider)
      .findAllByStudentCpf(cpf, position);
}
