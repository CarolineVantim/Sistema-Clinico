import 'package:sistema_clinico/features/clinicalcare/domain/clinical_care.dart';

abstract class ClinicalCareRepository {
  Future<List<ClinicalCare>> findAllByStudentCpf(String cpf);
}
