import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sistema_clinico/shared/data/providers/dio_provider.dart';
import 'package:sistema_clinico/features/clinicalcare/domain/clinical_care.dart';
import 'package:sistema_clinico/features/clinicalcare/domain/clinical_care_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'clinical_care_repository_impl.g.dart';

class ClinicalCareRepositoryImpl implements ClinicalCareRepository {
  final Dio dio;

  ClinicalCareRepositoryImpl({required this.dio});

  @override
  Future<List<ClinicalCare>> findAllByStudentCpf(String cpf) async {
    var response = await dio
        .get('/api/class_records/find_class_by_student_cpf?studentCpf=$cpf');
    return [for (final cc in response.data as List) ClinicalCare.fromJson(cc)];
  }
}

@riverpod
ClinicalCareRepository clinicalcareRepository(Ref ref) {
  return ClinicalCareRepositoryImpl(dio: ref.watch(dioProvider));
}

@riverpod
Future<List<ClinicalCare>> clinicalCareByStudentCpf(Ref ref, String cpf) async {
  return await ref
      .watch(clinicalcareRepositoryProvider)
      .findAllByStudentCpf(cpf);
}
