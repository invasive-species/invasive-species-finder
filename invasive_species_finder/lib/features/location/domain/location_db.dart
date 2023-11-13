
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

/// The data associated with locations.
class LocationData {
  LocationData({
    required this.id,
    required this.userID,
    required this.speciesID,
    required this.name,
    required this.attitude,
    required this.latitude,
  });

  String id;
  String userID;
  String speciesID;
  String name;
  double attitude;
  double latitude;
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
        attitude: 21.6824,
        latitude: -157.9515,
    ),
    LocationData(
        id: 'location-002',
        userID: 'user-001',
        speciesID: 'species-002',
        name: 'North Shore',
        attitude: 21.6481,
        latitude: -158.0624,
        ),
    LocationData(
        id: 'location-003',
        userID: 'user-001',
        speciesID: 'species-003',
        name: 'Ewa Beach',
        attitude: 21.3156,
        latitude: -158.0072,
        ),
    LocationData(
        id: 'location-004',
        userID: 'user-002',
        speciesID: 'species-001',
        name: 'Kapolei',
        attitude: 21.3358,
        latitude: -158.0560,
        ),
    LocationData(
        id: 'location-005',
        userID: 'user-002',
        speciesID: 'species-002',
        name: 'Kailua',
        attitude: 21.4022,
        latitude: -157.7394,
        ),
    LocationData(
        id: 'location-006',
        userID: 'user-003',
        speciesID: 'species-001',
        name: 'Wahiawa',
        attitude: 21.5025,
        latitude: -158.0236,
        ),
    LocationData(
        id: 'location-007',
        userID: 'user-003',
        speciesID: 'species-002',
        name: 'Somewhere',
        attitude: 0.0,
        latitude: 37.4226,
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

  Future<List<String>> getUserLocation() async {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high
      );
      double attitude = position.altitude;
      double latitude = position.latitude;
      print(attitude);
      print(latitude);
      return getLocationIDs()
          .where(
              (locationID) =>(
                (getLocations(locationID).latitude <= latitude + 0.5 &&
                    getLocations(locationID).latitude >= latitude - 0.5) &&
                    (getLocations(locationID).attitude >= attitude - 0.5 &&
                        getLocations(locationID).attitude <= attitude + 0.5)))
          .toList();

  }
}

