// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Family _$FamilyFromJson(Map<String, dynamic> json) => Family(
      cpf: json['cpf'] as String,
      name: json['name'] as String,
      gender: json['gender'] as String,
      address: json['address'] as String,
      phone: json['phone'] as String,
      zipCode: json['zipCode'] as String,
      kinshipDegree: json['kinshipDegree'] as String,
      birthDate: DateTime.parse(json['birthDate'] as String),
    );

Map<String, dynamic> _$FamilyToJson(Family instance) => <String, dynamic>{
      'cpf': instance.cpf,
      'name': instance.name,
      'gender': instance.gender,
      'address': instance.address,
      'phone': instance.phone,
      'zipCode': instance.zipCode,
      'kinshipDegree': instance.kinshipDegree,
      'birthDate': instance.birthDate.toIso8601String(),
    };
