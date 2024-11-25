import 'package:sistema_clinico/features/clinicalcare/domain/clinical_care.dart';

abstract class ClinicalCarePositionRepository {
  Future<List<ClinicalCare>> findAllByStudentCpf(String cpf, String position);
}
