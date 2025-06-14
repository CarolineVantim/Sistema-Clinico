import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'dio_provider.g.dart';

@riverpod
Dio dio(Ref ref) {
  return Dio(BaseOptions(baseUrl: dotenv.get("API_LINK")));
}

// final atendimentosPorCpfProvider =
//     FutureProvider.family<List<ClassRecordsModel>, int>((ref, string cpf) async {
//   var response = await ref.watch(dioProvider).get(
//       '/api/class_records/find_class_by_student_cpf?page=0&studentCpf=$cpf');
//   final atendimentos = [
//     for (final cr in response.data as List) ClassRecordsModel.fromJson(cr)
//   ];
//   print('Atendimentos: $atendimentos');
//   return atendimentos;
// });
