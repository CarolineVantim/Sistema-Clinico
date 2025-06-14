import 'package:sistema_clinico/shared/data/models/student.dart';


abstract class StudentsRepository {
  Future<List<Student>> getAllStudents();
}
