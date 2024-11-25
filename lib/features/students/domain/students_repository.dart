import 'students_model.dart';

abstract class StudentsRepository {
  Future<List<StudentModel>> getAllStudents();
}