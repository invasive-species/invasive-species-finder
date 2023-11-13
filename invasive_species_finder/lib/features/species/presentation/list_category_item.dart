// list_view_item.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../location/data/location_providers.dart';
import '../../species/data/species_providers.dart';
import '../../location/domain/location_db.dart';
import '../../species/domain/species_db.dart';

class ListCategoryItem extends ConsumerWidget {
  final String speciesID;

  const ListCategoryItem({
    required this.speciesID,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SpeciesDB speciesDB = ref.watch(speciesDBProvider);
    SpeciesData data = speciesDB.getSpecies(speciesID);
    String imagePath = data.imagePath;
    String name = data.name;
    String description = data.description;
    String category = data.category;
    String locationId = data.locationID;
    final LocationDB locationDB = ref.watch(locationDBProvider);
    String locationName = locationDB.getLocations(locationId).name;
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
