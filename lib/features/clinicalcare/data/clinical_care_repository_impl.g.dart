// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinical_care_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$clinicalcareRepositoryHash() =>
    r'7f135d291f78e5baf987454a61994720ca8adbf1';

/// See also [clinicalcareRepository].
@ProviderFor(clinicalcareRepository)
final clinicalcareRepositoryProvider =
    AutoDisposeProvider<ClinicalCareRepository>.internal(
  clinicalcareRepository,
  name: r'clinicalcareRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$clinicalcareRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ClinicalcareRepositoryRef
    = AutoDisposeProviderRef<ClinicalCareRepository>;
String _$clinicalCareByStudentCpfHash() =>
    r'4afbf7db9dadf7c81e7e0e56c3e470e9456408ee';

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

/// See also [clinicalCareByStudentCpf].
@ProviderFor(clinicalCareByStudentCpf)
const clinicalCareByStudentCpfProvider = ClinicalCareByStudentCpfFamily();

/// See also [clinicalCareByStudentCpf].
class ClinicalCareByStudentCpfFamily
    extends Family<AsyncValue<List<ClinicalCare>>> {
  /// See also [clinicalCareByStudentCpf].
  const ClinicalCareByStudentCpfFamily();

  /// See also [clinicalCareByStudentCpf].
  ClinicalCareByStudentCpfProvider call(
    String cpf,
  ) {
    return ClinicalCareByStudentCpfProvider(
      cpf,
    );
  }

  @override
  ClinicalCareByStudentCpfProvider getProviderOverride(
    covariant ClinicalCareByStudentCpfProvider provider,
  ) {
    return call(
      provider.cpf,
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
  String? get name => r'clinicalCareByStudentCpfProvider';
}

/// See also [clinicalCareByStudentCpf].
class ClinicalCareByStudentCpfProvider
    extends AutoDisposeFutureProvider<List<ClinicalCare>> {
  /// See also [clinicalCareByStudentCpf].
  ClinicalCareByStudentCpfProvider(
    String cpf,
  ) : this._internal(
          (ref) => clinicalCareByStudentCpf(
            ref as ClinicalCareByStudentCpfRef,
            cpf,
          ),
          from: clinicalCareByStudentCpfProvider,
          name: r'clinicalCareByStudentCpfProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$clinicalCareByStudentCpfHash,
          dependencies: ClinicalCareByStudentCpfFamily._dependencies,
          allTransitiveDependencies:
              ClinicalCareByStudentCpfFamily._allTransitiveDependencies,
          cpf: cpf,
        );

  ClinicalCareByStudentCpfProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.cpf,
  }) : super.internal();

  final String cpf;

  @override
  Override overrideWith(
    FutureOr<List<ClinicalCare>> Function(ClinicalCareByStudentCpfRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ClinicalCareByStudentCpfProvider._internal(
        (ref) => create(ref as ClinicalCareByStudentCpfRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        cpf: cpf,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ClinicalCare>> createElement() {
    return _ClinicalCareByStudentCpfProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ClinicalCareByStudentCpfProvider && other.cpf == cpf;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, cpf.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ClinicalCareByStudentCpfRef
    on AutoDisposeFutureProviderRef<List<ClinicalCare>> {
  /// The parameter `cpf` of this provider.
  String get cpf;
}

class _ClinicalCareByStudentCpfProviderElement
    extends AutoDisposeFutureProviderElement<List<ClinicalCare>>
    with ClinicalCareByStudentCpfRef {
  _ClinicalCareByStudentCpfProviderElement(super.provider);

  @override
  String get cpf => (origin as ClinicalCareByStudentCpfProvider).cpf;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
