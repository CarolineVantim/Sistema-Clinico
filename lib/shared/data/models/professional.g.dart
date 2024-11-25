// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'professional.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Professional _$ProfessionalFromJson(Map<String, dynamic> json) => Professional(
      crm: json['crm'] as String,
      cpf: json['cpf'] as String,
      name: json['name'] as String,
      gender: json['gender'] as String,
      fieldOfWork: (json['fieldOfWork'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      zipCode: json['zipCode'] as String?,
      position: json['position'] as String?,
      birthDate: json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
      student: (json['student'] as List<dynamic>?)
          ?.map((e) => Student.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProfessionalToJson(Professional instance) =>
    <String, dynamic>{
      'crm': instance.crm,
      'cpf': instance.cpf,
      'name': instance.name,
      'gender': instance.gender,
      'fieldOfWork': instance.fieldOfWork,
      'address': instance.address,
      'zipCode': instance.zipCode,
      'phone': instance.phone,
      'position': instance.position,
      'birthDate': instance.birthDate?.toIso8601String(),
      'student': instance.student,
    };
