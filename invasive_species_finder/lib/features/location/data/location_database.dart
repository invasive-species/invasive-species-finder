import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invasive_species_finder/features/location/domain/location.dart';

import '../../../repositories/firestore/firestore_path.dart';
import '../../../repositories/firestore/firestore_service.dart';

class LocationDatabase{
  LocationDatabase(this.ref);

  final ProviderRef<LocationDatabase> ref;

  final _service = FirestoreService.instance;

  Stream<List<Location>> watchLocations() => _service.watchCollection(
    path: FirestorePath.locations(),
    builder: (data, documentId) => Location.fromJson(data!),
  );

  Stream<Location> watchLocation(String locationId) => _service.watchDocument(
    path: FirestorePath.location(locationId),
    builder: (data, documentId) => Location.fromJson(data!),
  );

  Future<List<Location>> fetchLocations() => _service.fetchCollection(
    path: FirestorePath.locations(),
    builder: (data, documentId) => Location.fromJson(data!),
  );

  Future<Location> fetchLocation(String locationId) => _service.fetchDocument(
    path: FirestorePath.location(locationId),
    builder: (data, documentId) => Location.fromJson(data!),
  );

  Future<void> setLocation(Location location) => _service.setData(
    path: FirestorePath.location(location.id),
    data: location.toJson(),
  );
}
