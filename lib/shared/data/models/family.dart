import 'package:json_annotation/json_annotation.dart';

part 'family.g.dart';

@JsonSerializable()
class Family {
  String cpf;
  String name;
  String gender;
  String address;
  String phone;
  String zipCode;
  String kinshipDegree;
  DateTime birthDate;

  Family(
      {required this.cpf,
      required this.name,
      required this.gender,
      required this.address,
      required this.phone,
      required this.zipCode,
      required this.kinshipDegree,
      required this.birthDate});

  factory Family.fromJson(Map<String, dynamic> json) => _$FamilyFromJson(json);
  Map<String, dynamic> toJson() => _$FamilyToJson(this);

  @override
  String toString() {
    return 'Family(cpf: $cpf, name: $name, gender: $gender, address: $address, phone: $phone, zipCode: $zipCode, kinshipDegree: $kinshipDegree, birthDate: $birthDate)';
  }
}
