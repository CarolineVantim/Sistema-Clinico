// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinical_care.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClinicalCare _$ClinicalCareFromJson(Map<String, dynamic> json) => ClinicalCare(
      id: (json['id'] as num).toInt(),
      professional:
          Professional.fromJson(json['professional'] as Map<String, dynamic>),
      classDate: DateTime.parse(json['classDate'] as String),
      discipline: json['discipline'] as String,
      subject: json['subject'] as String,
      media: json['media'] == null
          ? null
          : Media.fromJson(json['media'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClinicalCareToJson(ClinicalCare instance) =>
    <String, dynamic>{
      'id': instance.id,
      'professional': instance.professional,
      'classDate': instance.classDate.toIso8601String(),
      'discipline': instance.discipline,
      'subject': instance.subject,
      'media': instance.media,
    };
