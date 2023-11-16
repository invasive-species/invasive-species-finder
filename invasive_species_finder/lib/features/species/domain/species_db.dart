/*
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The data associated with each species.
class SpeciesData {
  SpeciesData({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.imagePath,
    required this.locationID,
    required this.postID,
  });

  String id;
  String name;
  String description;
  String category;
  String locationID;
  String postID;
  String imagePath;
}

/// Provides access to and operations on all defined Gardens.
class SpeciesDB {
  SpeciesDB(this.ref);
  final ProviderRef<SpeciesDB> ref;
  final List<SpeciesData> _species = [
    SpeciesData(
        id: 'species-001',
        name: 'Species1',
        description: 'details of species1',
        imagePath: 'assets/images/garden-001.jpg',
        locationID: 'location-001',
        postID: 'post-001',
        category: 'animal',
    ),
    SpeciesData(
        id: 'species-002',
        name: 'Species2',
        description: 'details of species2',
        imagePath: 'assets/images/garden-002.jpg',
        locationID: 'location-002',
        postID: 'post-002',
        category: 'plant',
        ),
    SpeciesData(
        id: 'species-003',
        name: 'Species3',
        description: 'details of species3',
        imagePath: 'assets/images/garden-003.jpg',
        locationID: 'location-003',
        postID: 'post-003',
        category: 'plant',
        ),
    SpeciesData(
        id: 'species-004',
        name: 'Species4',
        description: 'details of species4',
        imagePath: 'assets/images/ohia-lehua.png',
        locationID: 'location-007',
        postID: 'post-004',
        category: 'plant',
    ),
  ];

  SpeciesData getSpecies(String speciesID) {
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
    SpeciesData data = getSpecies(speciesID);
    return (data.postID == postID);
  }

  bool _locationIsAssociated(String speciesID, String locationID) {
    SpeciesData data = getSpecies(speciesID);
    return (data.locationID == locationID);
  }
}

*/
