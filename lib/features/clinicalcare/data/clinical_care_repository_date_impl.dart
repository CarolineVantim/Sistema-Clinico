import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sistema_clinico/shared/data/providers/dio_provider.dart';
import 'package:sistema_clinico/features/clinicalcare/domain/clinical_care.dart';
import 'package:sistema_clinico/features/clinicalcare/domain/clinical_care_date_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'clinical_care_repository_date_impl.g.dart';

class ClinicalCareRepositoryImpl implements ClinicalCareDateRepository {
  final Dio dio;

  ClinicalCareRepositoryImpl({required this.dio});

  @override
  Future<List<ClinicalCare>> findAllByStudentCpf(
      String cpf, String date) async {
    var response = await dio.get(
        '/api/class_records/find_class_by_date?studentCpf=$cpf&date=$date');
    return [for (final cc in response.data as List) ClinicalCare.fromJson(cc)];
  }
}

@riverpod
ClinicalCareDateRepository clinicalcaredateRepository(Ref ref) {
  return ClinicalCareRepositoryImpl(dio: ref.watch(dioProvider));
}

@riverpod
Future<List<ClinicalCare>> clinicalCareByDate(
    Ref ref, String cpf, String date) async {
  return await ref
      .watch(clinicalcaredateRepositoryProvider)
      .findAllByStudentCpf(cpf, date);
}
