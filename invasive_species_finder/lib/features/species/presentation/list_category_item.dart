// list_view_item.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invasive_species_finder/features/species/domain/species_collection.dart';

import '../../common/all_data_provider.dart';
import '../../common/isf_error.dart';
import '../../common/isf_loading.dart';
import '../../location/domain/location.dart';
import '../../location/domain/location_collection.dart';
import '../domain/species.dart';

class ListCategoryItem extends ConsumerWidget {
  final String speciesID;

  const ListCategoryItem({
    required this.speciesID,
    Key? key,
  }) : super(key: key);

  @override
  build(BuildContext context, WidgetRef ref){
    final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
    return asyncAllData.when(
      data: (allData) => _build(
        context: context,
        currentUserID: allData.currentUserID,
        species: allData.species,
        locations: allData.locations,
      ),
      error: (err, stack) => ISFError(err.toString(), stack.toString()),
      loading: () => const ISFLoading(),
    );
  }

  _build({
    required BuildContext context,
    required String currentUserID,
    required List<Species> species,
    required List<Location> locations,
}) {
    SpeciesCollection speciesCollection = SpeciesCollection(species);
    Species data = speciesCollection.getSpecies(speciesID);

    LocationCollection locationCollection = LocationCollection(locations);

    String imagePath = data.imagePath;
    String name = data.name;
    String description = data.description;
    String category = data.category;
    String locationId = data.locationID;

    String locationName = locationCollection.getLocation(locationId).name;
    AssetImage image = AssetImage(imagePath);
    return Card(
      elevation: 9,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            isThreeLine: true,
            title: Text(name),
            subtitle: Text('$description\n$category\n$locationName\n'),
          ),
          SizedBox(
            height: 200,
            child: Image(
              image: image,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Text('Location: $locationName')
        ],
      ),
      );
  }
}
