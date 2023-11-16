import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/species.dart';
import 'species_database.dart';

part 'species_providers.g.dart';

@riverpod
SpeciesDatabase speciesDatabase(SpeciesDatabaseRef ref) {
  return SpeciesDatabase(ref);
}

@riverpod
Stream<List<Species>> species(SpeciesRef ref) {
  final database = ref.watch(speciesDatabaseProvider);
  return database.watchSpeciess();
}
