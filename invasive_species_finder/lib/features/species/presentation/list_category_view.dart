import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invasive_species_finder/features/location/domain/location_db.dart';

import '../../location/data/location_providers.dart';
import '../data/species_providers.dart';
import 'list_category_item.dart';
import 'list_category_action.dart';

/// Displays a list of Categories.
class ListCategoryView extends ConsumerWidget {
  const ListCategoryView({
    super.key,
  });

  final String title = 'List of Species';
  static const routeName = '/list_species';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LocationDB locationDB = ref.watch(locationDBProvider);
    final speciesDB = ref.watch(speciesDBProvider);
    final locationIDs = ref.watch(locationIDsProvider);
    List<String> locations = locationIDs.when(
        data: (data) => data,
        loading: () => [],
        error: (error, stackTrace) => []);
    print(locations);
    List<String> speciesIDs = locations
        .map((locationID) => speciesDB.getAssociatedSpeciesIDs(locationID: locationID))
        .expand((element) => element)
        .toList();
    print(speciesIDs);
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: (speciesIDs.isEmpty)
              ? const Align(
                  alignment: Alignment.center,
                  child: Text("No species yet!"))
              : ListView(children: [
                  ...speciesIDs
                      .map((speciesID) => ListCategoryItem(speciesID: speciesID))
                      .toList()
                ])),
    );
  }
}
