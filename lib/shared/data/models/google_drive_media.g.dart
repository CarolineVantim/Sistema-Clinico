// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_drive_media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Media _$MediaFromJson(Map<String, dynamic> json) => Media(
      id: (json['id'] as num).toInt(),
      url: json['url'] as String,
      fileName: json['fileName'] as String,
      fileType: json['fileType'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$MediaToJson(Media instance) => <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'fileName': instance.fileName,
      'fileType': instance.fileType,
      'description': instance.description,
    };
