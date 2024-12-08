import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sistema_clinico/features/students/domain/students_model.dart';
import 'package:sistema_clinico/shared/data/models/student.dart';
import 'package:sistema_clinico/shared/data/providers/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/students_repository.dart';

part 'students_repository_impl.g.dart';

class StudentsRepositoryImpl implements StudentsRepository {
  final Dio dio;

  StudentsRepositoryImpl({required this.dio});

  @override
  Future<List<Student>> getAllStudents() async {
    try {
      final response = await dio.get('/api/student/view_all');

      // Verificação adicional para garantir que a resposta é uma lista
      if (response.data is! List) {
        log('Resposta inesperada: ${response.data}');
        throw Exception('A resposta do servidor não é uma lista de alunos.');
      }

      // Conversão para lista de StudentModel
      return [for (final s in response.data as List) Student.fromJson(s)];
    } on DioException catch (e) {
      // Log detalhado do erro
      log('Falha ao consultar alunos. Mensagem: ${e.message}, Erro: ${e.error}');
      throw Exception(
          'Falha ao consultar alunos. Verifique a conexão ou a resposta do servidor.');
    } catch (e) {
      // Tratamento para outros tipos de exceção
      log('Erro inesperado ao buscar alunos: $e');
      throw Exception('Erro inesperado ao buscar alunos.');
    }
  }
}

// Provider para StudentsRepository
@riverpod
StudentsRepository studentsRepository(Ref ref) {
  var dio = ref.watch(dioProvider);

  // Verificação de null ou erro durante a injeção de dependência
  if (dio == null) {
    throw Exception('Erro ao inicializar o DioProvider.');
  }

  return StudentsRepositoryImpl(dio: dio);
}

// Provider assíncrono para buscar os estudantes
@riverpod
Future<List<Student>> students(Ref ref) async {
  try {
    // Recupera a lista de estudantes usando o repositório
    List<Student> students =
        await ref.watch(studentsRepositoryProvider).getAllStudents();
    return students;
  } catch (e) {
    // Log detalhado do erro
    log('Erro ao buscar lista de estudantes: $e');
    throw Exception('Falha ao buscar lista de estudantes.');
  }
}
