import 'package:json_annotation/json_annotation.dart';
import 'package:sistema_clinico/shared/data/models/family.dart';

part 'student.g.dart';

@JsonSerializable()
class Student {
  String cpf;
  String name;
  String disabilityType;
  DateTime birthDate;
  String? studentImage;
  List<Family>? family;
  Student(
      {required this.cpf,
      required this.name,
      required this.disabilityType,
      required this.birthDate,
      this.studentImage,
      this.family});

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);
  Map<String, dynamic> toJson() => _$StudentToJson(this);

  @override
  String toString() {
    return 'Student(cpf: $cpf, name: $name, disabilityType: $disabilityType, birthDate: $birthDate, studentImage: $studentImage)';
  }

  /* Cria um JSON do objeto student recebido e retorna uma string dele em formado de params
    Exemplo: cpf=40028922&name=XXXXXX&disabilityType=XXXXXX&birthDate=YYYY-MM-DD */
  String toParams(Student student) {
    Map<String, dynamic> paramsMap = student.toJson();
    paramsMap['birthDate'] = paramsMap['birthDate'].split('T')[0];
    paramsMap.removeWhere((key, value) => value == null || value == '');

    return paramsMap.entries
        .map((entry) => '${entry.key}=${entry.value}')
        .join('&');
  }
}
