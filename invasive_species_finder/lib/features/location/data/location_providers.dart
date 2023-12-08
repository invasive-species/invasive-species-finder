import 'package:geolocator/geolocator.dart';
import 'package:invasive_species_finder/features/location/data/location_database.dart';
import 'package:invasive_species_finder/features/location/domain/location_collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:permission_handler/permission_handler.dart';

import '../domain/location.dart';

part 'location_providers.g.dart';

@riverpod
LocationDatabase locationDatabase(LocationDatabaseRef ref) {
  return LocationDatabase(ref);
}

@riverpod
Stream<List<Location>> locations(LocationsRef ref) {
  final database = ref.watch(locationDatabaseProvider);
  return database.watchLocations();
}

@riverpod
Future<Position> currentLocation(CurrentLocationRef ref) async {
  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
  );
}

@riverpod
Future<List<String>> currentLocationIDs(CurrentLocationIDsRef ref) async {
  var locationPermission = await Permission.location.request();
  if (locationPermission.isGranted) {
    final Position position = await ref.watch(currentLocationProvider.future);
    final locations = await ref.watch(locationsProvider.future);
    double attitude = position.altitude;
    double latitude = position.latitude;
    LocationCollection locationCollection = LocationCollection(locations);
    return locationCollection.getLocationIDs()
        .where(
            (locationID) =>
        (
            (locationCollection
                .getLocation(locationID)
                .latitude <= latitude + 0.5 &&
                locationCollection
                    .getLocation(locationID)
                    .latitude >= latitude - 0.5) &&
                (locationCollection
                    .getLocation(locationID)
                    .attitude >= attitude - 0.5 &&
                    locationCollection
                        .getLocation(locationID)
                        .attitude <= attitude + 0.5)))
        .toList();
  } else {
    openAppSettings();
    return [];
  }
}

/*
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/location_db.dart';

final locationDBProvider = Provider<LocationDB>((ref) {
  return LocationDB(ref);
});

final locationIDsProvider = FutureProvider<List<String>>((ref) async {
  final locationDB = ref.watch(locationDBProvider); // Assuming you have a locationDBProvider
  return await locationDB.getUserLocation();
});
*/
