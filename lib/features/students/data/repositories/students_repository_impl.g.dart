// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'students_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$studentsRepositoryHash() =>
    r'24f7f52295169d18f864f7bf4ed6f83acf29ebc6';

/// See also [studentsRepository].
@ProviderFor(studentsRepository)
final studentsRepositoryProvider =
    AutoDisposeProvider<StudentsRepository>.internal(
  studentsRepository,
  name: r'studentsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$studentsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StudentsRepositoryRef = AutoDisposeProviderRef<StudentsRepository>;
String _$studentsHash() => r'f0e7e04470da3dc274d787ed8dd0fe5389f54702';

/// See also [students].
@ProviderFor(students)
final studentsProvider = AutoDisposeFutureProvider<List<StudentModel>>.internal(
  students,
  name: r'studentsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$studentsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StudentsRef = AutoDisposeFutureProviderRef<List<StudentModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
