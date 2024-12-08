import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'google_drive_media.dart';
import 'professional.dart';
import 'student.dart';

part 'class_records_model.freezed.dart';
part 'class_records_model.g.dart';

@freezed
class ClassRecordsModel with _$ClassRecordsModel {
  factory ClassRecordsModel({
    int? id,
    Professional? professional,
    String? classDate,
    String? startTime,
    String? endTime,
    String? subject,
    String? status,
    String? location,
    String? discipline,
    List<String?>? notes,
    Media? media,
    Student? student,
  }) = _ClassRecordsModel;

  factory ClassRecordsModel.fromJson(Map<String, dynamic> json) =>
      _$ClassRecordsModelFromJson(json);
}
