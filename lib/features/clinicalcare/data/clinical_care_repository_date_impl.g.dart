// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinical_care_repository_date_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$clinicalcaredateRepositoryHash() =>
    r'ae95f2bab2f305df467f97acfecc29722301fac5';

/// See also [clinicalcaredateRepository].
@ProviderFor(clinicalcaredateRepository)
final clinicalcaredateRepositoryProvider =
    AutoDisposeProvider<ClinicalCareDateRepository>.internal(
  clinicalcaredateRepository,
  name: r'clinicalcaredateRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$clinicalcaredateRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ClinicalcaredateRepositoryRef
    = AutoDisposeProviderRef<ClinicalCareDateRepository>;
String _$clinicalCareByDateHash() =>
    r'b98579fb9382363e4dd8861644e437601fb76429';

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

/// See also [clinicalCareByDate].
@ProviderFor(clinicalCareByDate)
const clinicalCareByDateProvider = ClinicalCareByDateFamily();

/// See also [clinicalCareByDate].
class ClinicalCareByDateFamily extends Family<AsyncValue<List<ClinicalCare>>> {
  /// See also [clinicalCareByDate].
  const ClinicalCareByDateFamily();

  /// See also [clinicalCareByDate].
  ClinicalCareByDateProvider call(
    String cpf,
    String date,
  ) {
    return ClinicalCareByDateProvider(
      cpf,
      date,
    );
  }

  @override
  ClinicalCareByDateProvider getProviderOverride(
    covariant ClinicalCareByDateProvider provider,
  ) {
    return call(
      provider.cpf,
      provider.date,
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
  String? get name => r'clinicalCareByDateProvider';
}

/// See also [clinicalCareByDate].
class ClinicalCareByDateProvider
    extends AutoDisposeFutureProvider<List<ClinicalCare>> {
  /// See also [clinicalCareByDate].
  ClinicalCareByDateProvider(
    String cpf,
    String date,
  ) : this._internal(
          (ref) => clinicalCareByDate(
            ref as ClinicalCareByDateRef,
            cpf,
            date,
          ),
          from: clinicalCareByDateProvider,
          name: r'clinicalCareByDateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$clinicalCareByDateHash,
          dependencies: ClinicalCareByDateFamily._dependencies,
          allTransitiveDependencies:
              ClinicalCareByDateFamily._allTransitiveDependencies,
          cpf: cpf,
          date: date,
        );

  ClinicalCareByDateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.cpf,
    required this.date,
  }) : super.internal();

  final String cpf;
  final String date;

  @override
  Override overrideWith(
    FutureOr<List<ClinicalCare>> Function(ClinicalCareByDateRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ClinicalCareByDateProvider._internal(
        (ref) => create(ref as ClinicalCareByDateRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        cpf: cpf,
        date: date,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ClinicalCare>> createElement() {
    return _ClinicalCareByDateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ClinicalCareByDateProvider &&
        other.cpf == cpf &&
        other.date == date;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, cpf.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ClinicalCareByDateRef
    on AutoDisposeFutureProviderRef<List<ClinicalCare>> {
  /// The parameter `cpf` of this provider.
  String get cpf;

  /// The parameter `date` of this provider.
  String get date;
}

class _ClinicalCareByDateProviderElement
    extends AutoDisposeFutureProviderElement<List<ClinicalCare>>
    with ClinicalCareByDateRef {
  _ClinicalCareByDateProviderElement(super.provider);

  @override
  String get cpf => (origin as ClinicalCareByDateProvider).cpf;
  @override
  String get date => (origin as ClinicalCareByDateProvider).date;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
