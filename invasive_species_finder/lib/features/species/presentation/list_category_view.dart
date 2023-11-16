import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invasive_species_finder/features/species/domain/species_collection.dart';

import '../../common/all_data_provider.dart';
import '../../common/isf_error.dart';
import '../../common/isf_loading.dart';
import '../domain/species.dart';
import 'list_category_item.dart';

/// Displays a list of Categories.
class ListCategoryView extends ConsumerWidget {
  const ListCategoryView({
    super.key,
  });

  final String title = 'List of Species';
  static const routeName = '/list_species';

  @override
  build(BuildContext context, WidgetRef ref){
    final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
    return asyncAllData.when(
      data: (allData) => _build(
        context: context,
        currentUserID: allData.currentUserID,
        species: allData.species,
        currentLocationIDs: allData.currentLocationIDs,
      ),
      error: (err, stack) => ISFError(err.toString(), stack.toString()),
      loading: () => const ISFLoading(),
    );
  }

  _build({
    required BuildContext context,
    required String currentUserID,
    required List<Species> species,
    required List<String> currentLocationIDs,
}) {
    SpeciesCollection speciesCollection = SpeciesCollection(species);
    List<String> speciesIDs = currentLocationIDs
        .map((locationID) => speciesCollection.getAssociatedSpeciesIDs(locationID: locationID))
        .expand((element) => element)
        .toList();

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
