import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invasive_species_finder/features/common/all_data_provider.dart';
import 'package:invasive_species_finder/features/species/domain/species_collection.dart';
import '../../common/isf_error.dart';
import '../../common/isf_loading.dart';
import '../domain/species.dart';

class SpeciesDetailView extends ConsumerWidget {
  final String speciesID;

  const SpeciesDetailView({
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
      ),
      error: (err, stack) => ISFError(err.toString(), stack.toString()),
      loading: () => const ISFLoading(),
    );
  }

  _build({
    required BuildContext context,
    required String currentUserID,
    required List<Species> species}){
    SpeciesCollection speciesCollection = SpeciesCollection(species);
    Species data = speciesCollection.getSpecies(speciesID);

    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    data.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  data.category,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        data.description,
        softWrap: true,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(data.name),
      ),
      body: ListView(
        children: [
          Image.asset(
            data.imagePath,
            width: 600,
            height: 240,
            fit: BoxFit.cover,
          ),
          titleSection,
          textSection,
        ],
      ),
    );
  }
}
