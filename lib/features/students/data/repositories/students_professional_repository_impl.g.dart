// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'students_professional_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$studentsprofessionalRepositoryHash() =>
    r'69ce2d62590b09a7c97fe5da8b7d8f9aa7950cc2';

/// See also [studentsprofessionalRepository].
@ProviderFor(studentsprofessionalRepository)
final studentsprofessionalRepositoryProvider =
    AutoDisposeProvider<StudentsRepository>.internal(
  studentsprofessionalRepository,
  name: r'studentsprofessionalRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$studentsprofessionalRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StudentsprofessionalRepositoryRef
    = AutoDisposeProviderRef<StudentsRepository>;
String _$studentsprofessionalHash() =>
    r'6b11113decc879fcd64b60587ae3cd47038b8df6';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [studentsprofessional].
@ProviderFor(studentsprofessional)
const studentsprofessionalProvider = StudentsprofessionalFamily();

/// See also [studentsprofessional].
class StudentsprofessionalFamily extends Family<AsyncValue<List<Student>>> {
  /// See also [studentsprofessional].
  const StudentsprofessionalFamily();

  /// See also [studentsprofessional].
  StudentsprofessionalProvider call(
    String nome,
  ) {
    return StudentsprofessionalProvider(
      nome,
    );
  }

  @override
  StudentsprofessionalProvider getProviderOverride(
    covariant StudentsprofessionalProvider provider,
  ) {
    return call(
      provider.nome,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'studentsprofessionalProvider';
}

/// See also [studentsprofessional].
class StudentsprofessionalProvider
    extends AutoDisposeFutureProvider<List<Student>> {
  /// See also [studentsprofessional].
  StudentsprofessionalProvider(
    String nome,
  ) : this._internal(
          (ref) => studentsprofessional(
            ref as StudentsprofessionalRef,
            nome,
          ),
          from: studentsprofessionalProvider,
          name: r'studentsprofessionalProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$studentsprofessionalHash,
          dependencies: StudentsprofessionalFamily._dependencies,
          allTransitiveDependencies:
              StudentsprofessionalFamily._allTransitiveDependencies,
          nome: nome,
        );

  StudentsprofessionalProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.nome,
  }) : super.internal();

  final String nome;

  @override
  Override overrideWith(
    FutureOr<List<Student>> Function(StudentsprofessionalRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StudentsprofessionalProvider._internal(
        (ref) => create(ref as StudentsprofessionalRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        nome: nome,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Student>> createElement() {
    return _StudentsprofessionalProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StudentsprofessionalProvider && other.nome == nome;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, nome.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin StudentsprofessionalRef on AutoDisposeFutureProviderRef<List<Student>> {
  /// The parameter `nome` of this provider.
  String get nome;
}

class _StudentsprofessionalProviderElement
    extends AutoDisposeFutureProviderElement<List<Student>>
    with StudentsprofessionalRef {
  _StudentsprofessionalProviderElement(super.provider);

  @override
  String get nome => (origin as StudentsprofessionalProvider).nome;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
