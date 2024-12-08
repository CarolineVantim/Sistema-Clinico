import 'package:sistema_clinico/shared/data/models/student.dart';

import 'students_model.dart';

abstract class StudentsRepository {
  Future<List<Student>> getAllStudents();
}
