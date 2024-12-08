// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_records_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClassRecordsModelImpl _$$ClassRecordsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ClassRecordsModelImpl(
      id: (json['id'] as num?)?.toInt(),
      professional: json['professional'] == null
          ? null
          : Professional.fromJson(json['professional'] as Map<String, dynamic>),
      classDate: json['classDate'] as String?,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      subject: json['subject'] as String?,
      status: json['status'] as String?,
      location: json['location'] as String?,
      discipline: json['discipline'] as String?,
      notes:
          (json['notes'] as List<dynamic>?)?.map((e) => e as String?).toList(),
      media: json['media'] == null
          ? null
          : Media.fromJson(json['media'] as Map<String, dynamic>),
      student: json['student'] == null
          ? null
          : Student.fromJson(json['student'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ClassRecordsModelImplToJson(
        _$ClassRecordsModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'professional': instance.professional,
      'classDate': instance.classDate,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'subject': instance.subject,
      'status': instance.status,
      'location': instance.location,
      'discipline': instance.discipline,
      'notes': instance.notes,
      'media': instance.media,
      'student': instance.student,
    };
