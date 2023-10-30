import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/species_db.dart';

final speciesDBProvider = Provider<SpeciesDB>((ref) {
  return SpeciesDB(ref);
});
