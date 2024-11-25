import 'package:json_annotation/json_annotation.dart';

part 'google_drive_media.g.dart';

@JsonSerializable()
class Media {
  int id;
  String url;
  String fileName;
  String fileType;
  String description;
  Media(
      {required this.id,
      required this.url,
      required this.fileName,
      required this.fileType,
      required this.description});

  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);
  Map<String, dynamic> toJson() => _$MediaToJson(this);

  @override
  String toString() {
    return 'Media(id: $id, url: $url, fileName: $fileName, fileType: $fileType, description: $description)';
  }
}
