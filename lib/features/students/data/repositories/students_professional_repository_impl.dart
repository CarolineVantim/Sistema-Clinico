import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sistema_clinico/features/students/domain/students_model.dart';
import 'package:sistema_clinico/shared/data/providers/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:sistema_clinico/features/students/domain/students_professional_repository.dart';

part 'students_professional_repository_impl.g.dart';

class StudentsRepositoryImpl implements StudentsRepository {
  final Dio dio;

  StudentsRepositoryImpl({required this.dio});

  @override
  Future<List<StudentModel>> getStudentsByName(String nome) async {
    try {
      final response = await dio.get('/api/student/find_by?name=$nome');
      return [for (final s in response.data as List) StudentModel.fromJson(s)];
    } on DioException catch (e) {
      log('Falha ao consultar alunos. Error: ${e.error.toString()}');
      throw Exception('Falha ao consultar alunos.');
    }
  }
}

@riverpod
StudentsRepository studentsprofessionalRepository(Ref ref) {
  var dio = ref.watch(dioProvider);
  return StudentsRepositoryImpl(dio: dio);
}

@riverpod
Future<List<StudentModel>> studentsprofessional(Ref ref, String nome) async {
  List<StudentModel> students = await ref
      .watch(studentsprofessionalRepositoryProvider)
      .getStudentsByName(nome);
  return students;
}
