import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/location_db.dart';

final locationDBProvider = Provider<LocationDB>((ref) {
  return LocationDB(ref);
});

final locationIDsProvider = FutureProvider<List<String>>((ref) async {
  final locationDB = ref.watch(locationDBProvider); // Assuming you have a locationDBProvider
  return await locationDB.getUserLocation();
});
