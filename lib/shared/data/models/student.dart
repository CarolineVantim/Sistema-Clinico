import 'dart:convert';
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

  Student({
    required this.cpf,
    required this.name,
    required this.disabilityType,
    required this.birthDate,
    this.studentImage,
    this.family,
  });

  // Método para criar uma instância de Student a partir de um JSON
  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);

  // Método para converter a instância de Student para um JSON
  Map<String, dynamic> toJson() => _$StudentToJson(this);

  // Método para converter uma lista de StudentModel para uma lista de Student
  static List<Student> fromModelList(List<StudentModel> modelList) {
    return modelList
        .map((model) => Student(
              cpf: model.cpf,
              name: model.name,
              disabilityType: model.disabilityType,
              birthDate: model.birthDate,
              studentImage: model.studentImage,
            ))
        .toList();
  }

  // Método para converter uma lista de Student para JSON
  static String toJsonList(List<Student> students) {
    return json.encode(List<dynamic>.from(students.map((x) => x.toJson())));
  }

  @override
  String toString() {
    return 'Student(cpf: $cpf, name: $name, disabilityType: $disabilityType, birthDate: $birthDate, studentImage: $studentImage)';
  }

  // Cria uma string de parâmetros para requisições, por exemplo: cpf=40028922&name=XXXXXX&birthDate=YYYY-MM-DD
  String toParams() {
    Map<String, dynamic> paramsMap = this.toJson();
    paramsMap['birthDate'] = paramsMap['birthDate'].split('T')[0];
    paramsMap.removeWhere((key, value) => value == null || value == '');
    return paramsMap.entries
        .map((entry) => '${entry.key}=${entry.value}')
        .join('&');
  }
}

// Classe StudentModel para ajudar na conversão de dados quando necessário
class StudentModel {
  String cpf;
  String name;
  String disabilityType;
  DateTime birthDate;
  String? studentImage;

  StudentModel({
    required this.cpf,
    required this.name,
    required this.disabilityType,
    required this.birthDate,
    this.studentImage,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        cpf: json["cpf"],
        name: json["name"],
        disabilityType: json["disabilityType"],
        birthDate: DateTime.parse(json["birthDate"]),
        studentImage: json["studentImage"],
      );

  Map<String, dynamic> toJson() => {
        "cpf": cpf,
        "name": name,
        "disabilityType": disabilityType,
        "birthDate":
            "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
        "studentImage": studentImage,
      };
}
