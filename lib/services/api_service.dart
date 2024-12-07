import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistema_clinico/shared/constants/api_constants.dart';

class ApiClient {
  final Dio _dio = Dio();

  FutureOr<Map<String, dynamic>> authAuthenticate(
      String cpfcrm, String password) async {
    String link = (dotenv.get('API_LINK') + ApiConstants.authAuthenticate);

    Map<String, dynamic> requestBody = {
      "username": cpfcrm,
      "password": password,
    };

    Response response = await _dio.post(link, data: requestBody);

    print('Response Status Code: ${response.statusCode}');
    print('Response Data: ${response.data}');

    if (response.statusCode == 200) {
      var responseData = response.data;

      if (responseData != null &&
          responseData['username'] != null &&
          responseData['token'] != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        prefs.setString('username', responseData['username']);
        prefs.setString('token', responseData['token']);

        return {
          "statusCode": response.statusCode,
          "data": responseData,
        };
      } else {
        throw Exception(
            'Estrutura de dados inválida ou campos ausentes na resposta da API.');
      }
    } else {
      throw Exception(
          'Falha na autenticação com código: ${response.statusCode}');
    }
  }

  Future<void> logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.remove('username');
      await prefs.remove('token');

      print("Usuário desconectado com sucesso.");
    } catch (e) {
      print("Erro ao fazer logout: $e");
      throw Exception("Erro ao fazer logout.");
    }
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
        data: {'id': id},
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
