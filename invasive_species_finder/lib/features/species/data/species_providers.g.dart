// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'species_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$speciesDatabaseHash() => r'179ee427edea067c35333c10c23c0ba83f480234';

/// See also [speciesDatabase].
@ProviderFor(speciesDatabase)
final speciesDatabaseProvider = AutoDisposeProvider<SpeciesDatabase>.internal(
  speciesDatabase,
  name: r'speciesDatabaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$speciesDatabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SpeciesDatabaseRef = AutoDisposeProviderRef<SpeciesDatabase>;
String _$speciesHash() => r'd7d09df3b911cc42f6fe0ab2acd43b1f52ddec07';

/// See also [species].
@ProviderFor(species)
final speciesProvider = AutoDisposeStreamProvider<List<Species>>.internal(
  species,
  name: r'speciesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$speciesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SpeciesRef = AutoDisposeStreamProviderRef<List<Species>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
