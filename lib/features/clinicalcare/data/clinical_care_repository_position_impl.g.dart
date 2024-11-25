// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinical_care_repository_position_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$clinicalcarepositionRepositoryHash() =>
    r'b7d031556b105c275bc8416f4f6954a9bf32a60c';

/// See also [clinicalcarepositionRepository].
@ProviderFor(clinicalcarepositionRepository)
final clinicalcarepositionRepositoryProvider =
    AutoDisposeProvider<ClinicalCarePositionRepository>.internal(
  clinicalcarepositionRepository,
  name: r'clinicalcarepositionRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$clinicalcarepositionRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ClinicalcarepositionRepositoryRef
    = AutoDisposeProviderRef<ClinicalCarePositionRepository>;
String _$clinicalCareByPositionHash() =>
    r'9d962f8949fbbd1441ba7b8b53c89cab610e0289';

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

/// See also [clinicalCareByPosition].
@ProviderFor(clinicalCareByPosition)
const clinicalCareByPositionProvider = ClinicalCareByPositionFamily();

/// See also [clinicalCareByPosition].
class ClinicalCareByPositionFamily
    extends Family<AsyncValue<List<ClinicalCare>>> {
  /// See also [clinicalCareByPosition].
  const ClinicalCareByPositionFamily();

  /// See also [clinicalCareByPosition].
  ClinicalCareByPositionProvider call(
    String cpf,
    String position,
  ) {
    return ClinicalCareByPositionProvider(
      cpf,
      position,
    );
  }

  @override
  ClinicalCareByPositionProvider getProviderOverride(
    covariant ClinicalCareByPositionProvider provider,
  ) {
    return call(
      provider.cpf,
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
  String? get name => r'clinicalCareByPositionProvider';
}

/// See also [clinicalCareByPosition].
class ClinicalCareByPositionProvider
    extends AutoDisposeFutureProvider<List<ClinicalCare>> {
  /// See also [clinicalCareByPosition].
  ClinicalCareByPositionProvider(
    String cpf,
    String position,
  ) : this._internal(
          (ref) => clinicalCareByPosition(
            ref as ClinicalCareByPositionRef,
            cpf,
            position,
          ),
          from: clinicalCareByPositionProvider,
          name: r'clinicalCareByPositionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$clinicalCareByPositionHash,
          dependencies: ClinicalCareByPositionFamily._dependencies,
          allTransitiveDependencies:
              ClinicalCareByPositionFamily._allTransitiveDependencies,
          cpf: cpf,
          position: position,
        );

  ClinicalCareByPositionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.cpf,
    required this.position,
  }) : super.internal();

  final String cpf;
  final String position;

  @override
  Override overrideWith(
    FutureOr<List<ClinicalCare>> Function(ClinicalCareByPositionRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ClinicalCareByPositionProvider._internal(
        (ref) => create(ref as ClinicalCareByPositionRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        cpf: cpf,
        position: position,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ClinicalCare>> createElement() {
    return _ClinicalCareByPositionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ClinicalCareByPositionProvider &&
        other.cpf == cpf &&
        other.position == position;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, cpf.hashCode);
    hash = _SystemHash.combine(hash, position.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ClinicalCareByPositionRef
    on AutoDisposeFutureProviderRef<List<ClinicalCare>> {
  /// The parameter `cpf` of this provider.
  String get cpf;

  /// The parameter `position` of this provider.
  String get position;
}

class _ClinicalCareByPositionProviderElement
    extends AutoDisposeFutureProviderElement<List<ClinicalCare>>
    with ClinicalCareByPositionRef {
  _ClinicalCareByPositionProviderElement(super.provider);

  @override
  String get cpf => (origin as ClinicalCareByPositionProvider).cpf;
  @override
  String get position => (origin as ClinicalCareByPositionProvider).position;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
