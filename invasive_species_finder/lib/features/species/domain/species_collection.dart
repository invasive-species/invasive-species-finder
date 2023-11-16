import 'species.dart';

class SpeciesCollection {
  SpeciesCollection(species) : _species = species;

  final List<Species> _species;

  int size() {
    return _species.length;
  }

  Species getSpecies(String speciesID) {
    return _species.firstWhere((data) => data.id == speciesID);
  }

  List<String> getSpeciesIDs() {
    return _species.map((data) => data.id).toList();
  }

  String getSpeciesName(String speciesID) {
    return _species.firstWhere((data) => data.id == speciesID).name;
  }

  String getSpeciesIDFromName(String speciesName) {
    return _species.firstWhere((data) => data.name == speciesName).id;
  }

  List<String> getSpeciesNames() {
    return _species.map((data) => data.name).toList();
  }

  List<String> getAssociatedSpeciesIDs({String? postID, String? locationID}) {
    if (postID != null) {
      return getSpeciesIDs()
          .where((speciesID) => _postIsAssociated(speciesID, postID))
          .toList();
    }
    if (locationID != null) {
      return getSpeciesIDs()
          .where((speciesID) => _locationIsAssociated(speciesID, locationID))
          .toList();
    }
    return [];
  }

  bool _postIsAssociated(String speciesID, String postID) {
    Species data = getSpecies(speciesID);
    return (data.postID == postID);
  }

  bool _locationIsAssociated(String speciesID, String locationID) {
    Species data = getSpecies(speciesID);
    return (data.locationID == locationID);
  }
}
