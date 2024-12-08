// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinical_care_repository_date_position_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$clinicalcaredatepositionRepositoryHash() =>
    r'76f95e80ce447a14a1618c45b2e4117403845d07';

/// See also [clinicalcaredatepositionRepository].
@ProviderFor(clinicalcaredatepositionRepository)
final clinicalcaredatepositionRepositoryProvider =
    AutoDisposeProvider<ClinicalCareDatePositionRepository>.internal(
  clinicalcaredatepositionRepository,
  name: r'clinicalcaredatepositionRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$clinicalcaredatepositionRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ClinicalcaredatepositionRepositoryRef
    = AutoDisposeProviderRef<ClinicalCareDatePositionRepository>;
String _$clinicalCareByDatePositionHash() =>
    r'19c17e9ba3302cd6eec8bc7aa159b02ec533b191';

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

/// See also [clinicalCareByDatePosition].
@ProviderFor(clinicalCareByDatePosition)
const clinicalCareByDatePositionProvider = ClinicalCareByDatePositionFamily();

/// See also [clinicalCareByDatePosition].
class ClinicalCareByDatePositionFamily
    extends Family<AsyncValue<List<ClinicalCare>>> {
  /// See also [clinicalCareByDatePosition].
  const ClinicalCareByDatePositionFamily();

  /// See also [clinicalCareByDatePosition].
  ClinicalCareByDatePositionProvider call(
    String cpf,
    String date,
    String position,
  ) {
    return ClinicalCareByDatePositionProvider(
      cpf,
      date,
      position,
    );
  }

  @override
  ClinicalCareByDatePositionProvider getProviderOverride(
    covariant ClinicalCareByDatePositionProvider provider,
  ) {
    return call(
      provider.cpf,
      provider.date,
      provider.position,
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
  String? get name => r'clinicalCareByDatePositionProvider';
}

/// See also [clinicalCareByDatePosition].
class ClinicalCareByDatePositionProvider
    extends AutoDisposeFutureProvider<List<ClinicalCare>> {
  /// See also [clinicalCareByDatePosition].
  ClinicalCareByDatePositionProvider(
    String cpf,
    String date,
    String position,
  ) : this._internal(
          (ref) => clinicalCareByDatePosition(
            ref as ClinicalCareByDatePositionRef,
            cpf,
            date,
            position,
          ),
          from: clinicalCareByDatePositionProvider,
          name: r'clinicalCareByDatePositionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$clinicalCareByDatePositionHash,
          dependencies: ClinicalCareByDatePositionFamily._dependencies,
          allTransitiveDependencies:
              ClinicalCareByDatePositionFamily._allTransitiveDependencies,
          cpf: cpf,
          date: date,
          position: position,
        );

  ClinicalCareByDatePositionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.cpf,
    required this.date,
    required this.position,
  }) : super.internal();

  final String cpf;
  final String date;
  final String position;

  @override
  Override overrideWith(
    FutureOr<List<ClinicalCare>> Function(
            ClinicalCareByDatePositionRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ClinicalCareByDatePositionProvider._internal(
        (ref) => create(ref as ClinicalCareByDatePositionRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        cpf: cpf,
        date: date,
        position: position,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ClinicalCare>> createElement() {
    return _ClinicalCareByDatePositionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ClinicalCareByDatePositionProvider &&
        other.cpf == cpf &&
        other.date == date &&
        other.position == position;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, cpf.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);
    hash = _SystemHash.combine(hash, position.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ClinicalCareByDatePositionRef
    on AutoDisposeFutureProviderRef<List<ClinicalCare>> {
  /// The parameter `cpf` of this provider.
  String get cpf;

  /// The parameter `date` of this provider.
  String get date;

  /// The parameter `position` of this provider.
  String get position;
}

class _ClinicalCareByDatePositionProviderElement
    extends AutoDisposeFutureProviderElement<List<ClinicalCare>>
    with ClinicalCareByDatePositionRef {
  _ClinicalCareByDatePositionProviderElement(super.provider);

  @override
  String get cpf => (origin as ClinicalCareByDatePositionProvider).cpf;
  @override
  String get date => (origin as ClinicalCareByDatePositionProvider).date;
  @override
  String get position =>
      (origin as ClinicalCareByDatePositionProvider).position;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
