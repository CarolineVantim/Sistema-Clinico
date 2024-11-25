import 'package:json_annotation/json_annotation.dart';
import 'package:sistema_clinico/shared/data/models/student.dart';

part 'professional.g.dart';

@JsonSerializable()
class Professional {
  String crm;
  String cpf;
  String name;
  String gender;
  List<String> fieldOfWork;
  String? address;
  String? zipCode;
  String? phone;
  String? position;
  DateTime? birthDate;
  List<Student>? student;
  Professional(
      {required this.crm,
      required this.cpf,
      required this.name,
      required this.gender,
      required this.fieldOfWork,
      required this.address,
      required this.phone,
      required this.zipCode,
      required this.position,
      required this.birthDate,
      this.student});

  factory Professional.fromJson(Map<String, dynamic> json) =>
      _$ProfessionalFromJson(json);
  Map<String, dynamic> toJson() => _$ProfessionalToJson(this);

  @override
  String toString() {
    return 'Professional(crm: $crm, name: $name, gender: $gender, fieldOfWork: $fieldOfWork, address: $address, phone: $phone, zipCode: $zipCode, position: $position, birthDate: $birthDate, student: $student)';
  }
}
