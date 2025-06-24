import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistema_clinico/shared/constants/api_constants.dart';

class ApiClient {
  final Dio _dio = Dio();

  FutureOr<Map<String, dynamic>> authAuthenticate(
      String username, String password) async {
    // Renomeado cpfcrm para username para clareza
    String link = (dotenv.get('API_LINK') + ApiConstants.authAuthenticate);

    Map<String, dynamic> requestBody = {
      "username": username, // Usamos o username que foi passado aqui
      "password": password,
    };

    Response response = await _dio.post(link, data: requestBody);

    print('Response Status Code (ApiClient): ${response.statusCode}');
    print('Response Data (ApiClient): ${response.data}');

    if (response.statusCode == 200) {
      var responseData = response.data;

      // ATENÇÃO: A API retorna 'userType', não 'username' na resposta de auth.
      // ELA RETORNA token e userType, então verificamos por eles.
      if (responseData != null &&
          responseData['token'] != null && // Verificando se 'token' existe
          responseData['userType'] != null) {
        // Verificando se 'userType' existe

        // NOTA: O username/cpfcrm não vem da API de volta,
        // então o salvamos do que foi enviado na requisição.
        // Ou, para manter a consistência, podemos retornar
        // o userType e token e deixar a LoginPage salvar o username.

        // AQUI ESTÁ A MUDANÇA PRINCIPAL NO RETORNO:
        // Retornamos o username que foi passado para a função,
        // junto com o token e userType que vieram da API.
        return {
          "statusCode": response.statusCode,
          "token": responseData['token'],
          "userType": responseData['userType'],
          "username": username, // Adicionamos o username que foi usado no login
        };
      } else {
        // Se a API retornou 200, mas a estrutura dos dados está errada (falta token ou userType)
        throw Exception(
            'Estrutura de dados inválida ou campos ausentes (token ou userType) na resposta da API de autenticação.');
      }
    } else {
      // Se o status code não for 200
      throw Exception(
          'Falha na autenticação com código: ${response.statusCode}');
    }
  }

  // --- Mantenha o restante do seu ApiClient inalterado ---

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

  FutureOr<Map<String, dynamic>> uploadImage(String imageBase64) async {
    String link = (dotenv.get('API_LINK') + ApiConstants.uploadImage);

    Map<String, dynamic> requestBody = {"imageBase64": imageBase64};

    Response response;
    Map<String, dynamic> retorno = {};
    try {
      response = await _dio.post(link, data: requestBody);

      retorno = {"statusCode": response.statusCode, "data": response.data};
    } catch (e) {
      print(e);
    }

    return retorno;
  }

  Future<Map<String, dynamic>> registerClassRecord(
    int professionalCrm,
    int studentCpf,
    List<int> imageIds,
    String classDate,
    String startTime,
    String endTime,
    String subject,
    String status,
    String location,
    String discipline,
  ) async {
    String link = dotenv.get('API_LINK') + ApiConstants.classRegister;

    Map<String, dynamic> requestBody = {
      "professional": {"crm": professionalCrm},
      "student": {"cpf": studentCpf},
      "imageIds": imageIds,
      "classDate": classDate,
      "startTime": startTime,
      "endTime": endTime,
      "subject": subject,
      "status": status,
      "location": location,
      "discipline": discipline,
    };

    try {
      Response response = await Dio().post(
        link,
        data: requestBody,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      return {
        "statusCode": response.statusCode,
        "data": response.data,
      };
    } catch (e) {
      return {
        "statusCode": 500,
        "error": e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> viewAllP() async {
    String link = dotenv.get('API_LINK') + ApiConstants.studentViewAll;

    try {
      Response response = await Dio().get(
        link,
        // data: requestBody,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      return {
        "statusCode": response.statusCode,
        "data": response.data,
      };
    } catch (e) {
      return {
        "statusCode": 500,
        "error": e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> viewAllClass() async {
    String link = dotenv.get('API_LINK') + ApiConstants.classResumeFind;

    try {
      Response response = await Dio().get(
        link,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      return {
        "statusCode": 500,
        "data": response.data,
      };
    } catch (e) {
      return {
        "statusCode": 500,
        "error": e.toString(),
      };
    }
  }
}
