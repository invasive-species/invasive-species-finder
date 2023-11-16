import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invasive_species_finder/repositories/firestore/firestore_service.dart';

import '../../../repositories/firestore/firestore_path.dart';
import '../domain/species.dart';

class SpeciesDatabase{
  SpeciesDatabase(this.ref);

  final ProviderRef<SpeciesDatabase> ref;

  final _service = FirestoreService.instance;

  Stream<List<Species>> watchSpeciess() => _service.watchCollection(
    path: FirestorePath.speciess(),
    builder: (data, documentId) => Species.fromJson(data!));

  Stream<Species> watchSpecies(String speciesId) => _service.watchDocument(
    path: FirestorePath.species(speciesId),
    builder: (data, documentId) => Species.fromJson(data!));

  Future<List<Species>> fetchSpeciess() => _service.fetchCollection(
    path: FirestorePath.speciess(),
    builder: (data, documentId) => Species.fromJson(data!));

  Future<Species> fetchSpecies(String speciesId) => _service.fetchDocument(
    path: FirestorePath.species(speciesId),
    builder: (data, documentId) => Species.fromJson(data!));

  Future<void> setSpecies(Species species) => _service.setData(
    path: FirestorePath.species(species.id), data: species.toJson());

  Future<void> setSpeciesDelayed(Species species) => Future.delayed(
    const Duration(milliseconds: 2000),
    () => _service.setData(
      path: FirestorePath.species(species.id), data: species.toJson()));

  Future<void> setSpeciesError(Species species) =>
    Future.delayed(const Duration(milliseconds: 2000), () => throw Error());

  Future<void> deleteSpecies(Species species) =>
    _service.deleteData(path: FirestorePath.species(species.id));
}
