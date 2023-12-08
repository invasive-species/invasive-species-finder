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
    List<String> allSpeciesIDs = speciesCollection.getSpeciesIDs();

    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (speciesIDs.isEmpty)
                const Align(
                    alignment: Alignment.center,
                    child: Text("No species found around this location!")),
              if (speciesIDs.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: _buildList(title: "Species Around", speciesIDs: speciesIDs),
                ),
              _buildList(title: "All Species", speciesIDs: allSpeciesIDs)
            ],
          )
          ));
  }

  _buildList({
    required String title,
    required List<String> speciesIDs,
}){
    return ListView(
      children: [
        ...speciesIDs
            .map((speciesID) => ListCategoryItem(speciesID: speciesID))
            .toList()
      ],
    );
  }
}
