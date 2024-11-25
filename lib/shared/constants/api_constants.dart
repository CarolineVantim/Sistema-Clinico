class ApiConstants {
  // static String baseUrl = 'http://10.0.100.118:8080/api';

  static String usersUpdate = '/users/update';
  static String usersView = '/users/view_users';
  static String usersFindBy = '/users/find_by';
  static String usersDelete = '/users/delete/'; //{id}

  static String authAuthenticate = '/api/auth/authenticate';
  static String authRegister = '/auth/register';

  static String studentUpdate = '/student/update';
  static String studentRegister = '/student/register';
  static String studentViewAll = '/student/view_all';
  static String studentFindBy = '/student/find_by';
  static String studentFindByProfessional =
      '/student/find_students_by_professional/'; //{professionalCrm}
  static String studentFindByFamily =
      '/student/find_students_by_family/'; //{familyCpf}
  static String studentDelete = '/student/delete'; //{id}

  static String classUpdate = '/class/update';
  static String classRegister = '/class/register';
  static String classFind = '/class/find_class';
  static String classDelete = '/class/delete'; //{id}

  static String professional = '/professional'; //
  static String professionalAssociate = '/associate_student/'; //
  static String professionalFindAll = '/find_all'; //
}
