import 'package:json_annotation/json_annotation.dart';
import 'package:sistema_clinico/shared/data/models/professional.dart';

import 'package:sistema_clinico/shared/data/models/google_drive_media.dart';

part 'clinical_care.g.dart';

@JsonSerializable()
class ClinicalCare {
  int id;
  Professional professional;
  DateTime classDate;
  String discipline;
  String subject;
  Media? media;
  ClinicalCare(
      {required this.id,
      required this.professional,
      required this.classDate,
      required this.discipline,
      required this.subject,
      this.media});

  factory ClinicalCare.fromJson(Map<String, dynamic> json) =>
      _$ClinicalCareFromJson(json);
  Map<String, dynamic> toJson() => _$ClinicalCareToJson(this);
}
