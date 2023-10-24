
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The data associated with locations.
class LocationData {
  LocationData({
    required this.id,
    required this.userID,
    required this.speciesID,
    required this.name,
  });

  String id;
  String userID;
  String speciesID;
  String name;
}

/// Provides access to and operations on all defined users.
class LocationDB {
  LocationDB(this.ref);
  final ProviderRef<LocationDB> ref;
  final List<LocationData> _locations = [
    LocationData(
        id: 'location-001',
        userID: 'user-001',
        speciesID: 'species-001',
        name: 'Kahuku Farms',
    ),
    LocationData(
        id: 'location-002',
        userID: 'user-001',
        speciesID: 'species-002',
        name: 'North Shore',
        ),
    LocationData(
        id: 'location-003',
        userID: 'user-001',
        speciesID: 'species-003',
        name: 'Ewa Beach',
        ),
    LocationData(
        id: 'location-004',
        userID: 'user-002',
        speciesID: 'species-001',
        name: 'Kapolei',
        ),
    LocationData(
        id: 'location-005',
        userID: 'user-002',
        speciesID: 'species-002',
        name: 'Kailua',
        ),
    LocationData(
        id: 'location-006',
        userID: 'user-003',
        speciesID: 'species-001',
        name: 'Wahiawa',
        ),
  ];

  List<String> getLocationIDs() {
    return _locations.map((data) => data.id).toList();
  }

  LocationData getLocations(locationID) {
    return _locations.firstWhere((data) => data.id == locationID);
  }

  List<String> getLocationNames() {
    return _locations.map((data) => data.name).toList();
  }

  String getLocationIDFromName(String name) {
    return _locations.firstWhere((data) => data.name == name).id;
  }

  List<String> getAssociatedLocationIDs(String userID) {
    return getLocationIDs()
        .where((locationID) => getLocations(locationID).userID == userID)
        .toList();
  }
}

final locationDBProvider = Provider<LocationDB>((ref) {
  return LocationDB(ref);
});
