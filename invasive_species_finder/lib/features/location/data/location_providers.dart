import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/location_db.dart';

final locationDBProvider = Provider<LocationDB>((ref) {
  return LocationDB(ref);
});
