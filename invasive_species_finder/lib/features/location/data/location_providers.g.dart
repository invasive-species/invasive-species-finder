// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$locationDatabaseHash() => r'aa2bf60a5249511996dcc07f69d37e737a31551b';

/// See also [locationDatabase].
@ProviderFor(locationDatabase)
final locationDatabaseProvider = AutoDisposeProvider<LocationDatabase>.internal(
  locationDatabase,
  name: r'locationDatabaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$locationDatabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LocationDatabaseRef = AutoDisposeProviderRef<LocationDatabase>;
String _$locationsHash() => r'1bf158ffe528be2c59c67c0769f1dc25a3c3eb15';

/// See also [locations].
@ProviderFor(locations)
final locationsProvider = AutoDisposeStreamProvider<List<Location>>.internal(
  locations,
  name: r'locationsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$locationsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LocationsRef = AutoDisposeStreamProviderRef<List<Location>>;
String _$currentLocationHash() => r'81e3b0fbbce8f91d6ba997163003dd46d7d31fe8';

/// See also [currentLocation].
@ProviderFor(currentLocation)
final currentLocationProvider = AutoDisposeFutureProvider<Position>.internal(
  currentLocation,
  name: r'currentLocationProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentLocationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CurrentLocationRef = AutoDisposeFutureProviderRef<Position>;
String _$currentLocationIDsHash() =>
    r'1c5b24addce59efa5e3a7d150dea158ae09f0dff';

/// See also [currentLocationIDs].
@ProviderFor(currentLocationIDs)
final currentLocationIDsProvider =
    AutoDisposeFutureProvider<List<String>>.internal(
  currentLocationIDs,
  name: r'currentLocationIDsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentLocationIDsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CurrentLocationIDsRef = AutoDisposeFutureProviderRef<List<String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
