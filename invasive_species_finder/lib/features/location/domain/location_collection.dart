import 'location.dart';

class LocationCollection {
  LocationCollection(locations) : _locations = locations;

  final List<Location> _locations;

  Location getLocation(String locationID) {
    return _locations.firstWhere((data) => data.id == locationID);
  }

  int size() {
    return _locations.length;
  }

  List<String> getLocationIDs() {
    return _locations.map((data) => data.id).toList();
  }

  List<String> getLocationNames() {
    return _locations.map((data) => data.name).toList();
  }

  String getLocationIDFromName(String name) {
    return _locations.firstWhere((data) => data.name == name).id;
  }

  List<String> getAssociatedLocationIDs(String userID) {
    return getLocationIDs()
        .where((locationID) => getLocation(locationID).userID == userID)
        .toList();
  }
/*
  Future<List<String>> getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
    );
    double attitude = position.altitude;
    double latitude = position.latitude;
    return getLocationIDs()
        .where(
            (locationID) =>(
            (getLocation(locationID).latitude <= latitude + 0.5 &&
                getLocation(locationID).latitude >= latitude - 0.5) &&
                (getLocation(locationID).attitude >= attitude - 0.5 &&
                    getLocation(locationID).attitude <= attitude + 0.5)))
        .toList();

  }
 */

}
