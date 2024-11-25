// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Student _$StudentFromJson(Map<String, dynamic> json) => Student(
      cpf: json['cpf'] as String,
      name: json['name'] as String,
      disabilityType: json['disabilityType'] as String,
      birthDate: DateTime.parse(json['birthDate'] as String),
      studentImage: json['studentImage'] as String?,
      family: (json['family'] as List<dynamic>?)
          ?.map((e) => Family.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'cpf': instance.cpf,
      'name': instance.name,
      'disabilityType': instance.disabilityType,
      'birthDate': instance.birthDate.toIso8601String(),
      'studentImage': instance.studentImage,
      'family': instance.family,
    };
