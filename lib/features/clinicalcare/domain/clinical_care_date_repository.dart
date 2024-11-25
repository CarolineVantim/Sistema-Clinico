import 'package:sistema_clinico/features/clinicalcare/domain/clinical_care.dart';

abstract class ClinicalCareDateRepository {
  Future<List<ClinicalCare>> findAllByStudentCpf(String cpf, String date);
}
