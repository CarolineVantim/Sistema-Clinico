import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sistema_clinico/shared/constants/api_constants.dart';

class ApiClient {
  final Dio _dio = Dio();

  FutureOr<Map<String, dynamic>> authAutenticate(
      String cpfcrm, String password) async {
    String link = (dotenv.get('API_LINK') + ApiConstants.authAuthenticate);

    Map<String, dynamic> requestBody = {
      "username": cpfcrm,
      "password": password
    };

    Response response = await _dio.post(link, data: requestBody);

    Map<String, dynamic> auth = {
      "statusCode": response.statusCode,
      "data": response.data
    };

    return auth;
  }

  FutureOr<Map<String, dynamic>> searchStudent(String id, String token) async {
    String link = (dotenv.get('API_LINK') + ApiConstants.studentFindBy);

    Map<String, dynamic> requestBody = {"id": id};
    Options options = Options(
      headers: {
        'Authorization': 'Bearer $token',
        'accept': '*/*',
      },
    );
    try {
      Response dioResponse = await Dio().post(
        link,
        data: {'id': id}, // Passando o ID no corpo da solicitação
        options: Options(
          headers: {
            'accept': '*/*',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      Map<String, dynamic> response = {
        "statusCode": dioResponse.statusCode,
        "data": dioResponse.data
      };
      return response;
    } catch (e) {
      Map<String, dynamic> response = {"erro": 'Erro: $e'};
      return response;
    }
  }

  FutureOr<Map<String, dynamic>> addStudent(String cpf, String name,
      String dtype, DateTime bday, String image, String token) async {
    String link = (dotenv.get('API_LINK') + ApiConstants.studentRegister);

    Map<String, dynamic> requestBody = {
      "cpf": cpf,
      "name": name,
      "disabilityType": dtype,
      "birthDate": bday.toString(),
      "studentImage": image
    };
    Options options = Options(
      headers: {'Authorization': 'Bearer $token'},
    );
    try {
      Response dioResponse =
          await _dio.post(link, data: requestBody, options: options);

      Map<String, dynamic> student = {
        "statusCode": dioResponse.statusCode,
        "data": dioResponse.data
      };
      return student;
    } catch (e) {
      Map<String, dynamic> response = {"erro": "Erro: $token"};
      return response;
    }
  }

  Future<List<dynamic>> findAllStudents(
      String typeUser, String cpfcrm, String token) async {
    if (typeUser == "professional" || typeUser == "family") {
      Options options = Options(headers: {"Authorization": "Bearer $token"});

      if (typeUser == "professional") {
        try {
          Response response = await _dio.get(
              options: options,
              dotenv.get('API_LINK') +
                  ApiConstants.studentFindByProfessional +
                  cpfcrm);

          return response.data;
        } catch (e) {
          return [
            {"error": e}
          ];
        }
      }

      if (typeUser == "family") {
        try {
          Response response = await _dio.get(
              options: options,
              dotenv.get('API_LINK') +
                  ApiConstants.studentFindByFamily +
                  cpfcrm);

          return response.data;
        } catch (e) {
          return [
            {"error": e}
          ];
        }
      }
    }
    return [
      {"error": "Allowed user types are professional and family"}
    ];
  }
}
