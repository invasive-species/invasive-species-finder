import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invasive_species_finder/features/common/all_data_provider.dart';
import 'package:invasive_species_finder/features/species/domain/species_collection.dart';
import '../../common/isf_error.dart';
import '../../common/isf_loading.dart';
import '../../location/domain/location.dart';
import '../../location/domain/location_collection.dart';
import '../../species/domain/species.dart';
import '../domain/forum_post.dart';
import '../domain/forum_post_collection.dart';

class PostDetail extends ConsumerWidget {
  final String postID;

  const PostDetail({
    required this.postID,
    Key? key,
  }) : super(key: key);

  @override
  build(BuildContext context, WidgetRef ref){
    final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
    return asyncAllData.when(
      data: (allData) => _build(
        context: context,
        currentUserID: allData.currentUserID,
        posts: allData.posts,
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
    required List<ForumPost> posts}){
    ForumPostCollection postCollection = ForumPostCollection(posts);
    ForumPost data = postCollection.getPost(postID);
    SpeciesCollection speciesCollection = SpeciesCollection(species);
    LocationCollection locationCollection = LocationCollection(locations);
    Species speciesData = speciesCollection.getSpecies(data.speciesID);
    Location locationData = locationCollection.getLocation(data.locationID);
    String speciesName = speciesData.name;
    String locationName = locationData.name;

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
                    data.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  data.date,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
                Text(
                  'Last updated: ${data.lastUpdate}',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
                Text(
                  'Location: $locationName',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
                Text(
                  'Species: $speciesName',
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
        data.body,
        softWrap: true,
      ),
    );

    Widget commentSection = Container(
      padding: const EdgeInsets.all(32),
      child: const Center(
        child: Text(
          'Comments',
          softWrap: true,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          )
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(data.title),
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
          commentSection,
        ],
      ),
    );
  }
}
