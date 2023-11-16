import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invasive_species_finder/features/forum/domain/forum_post_collection.dart';
import 'package:invasive_species_finder/features/location/domain/location_collection.dart';
import 'package:invasive_species_finder/features/species/domain/species_collection.dart';
import '../../common/all_data_provider.dart';
import '../../common/isf_error.dart';
import '../../common/isf_loading.dart';
import '../../forum/domain/forum_post.dart';
import '../../location/domain/location.dart';
import '../../species/domain/species.dart';
import 'user_avatar.dart';

class PostCardView extends ConsumerWidget {
  const PostCardView({Key? key, required this.postID}) : super(key: key);

  final String postID;

  @override
  build(BuildContext context, WidgetRef ref){
    final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
    return asyncAllData.when(
      data: (allData) => _build(
        context: context,
        currentUserID: allData.currentUserID,
        posts: allData.posts,
        locations: allData.locations,
        species: allData.species,
      ),
      error: (err, stack) => ISFError(err.toString(), stack.toString()),
      loading: () => const ISFLoading(),
    );
  }

  Widget _build(
      {required BuildContext context,
        required String currentUserID,
        required List<ForumPost> posts,
        required List<Location> locations,
      required List<Species> species}) {
    ForumPostCollection forumPostCollection = ForumPostCollection(posts);
    ForumPost post = forumPostCollection.getPost(postID);

    LocationCollection locationCollection = LocationCollection(locations);
    String locationName = locationCollection.getLocation(post.locationID).name;

    SpeciesCollection speciesCollection = SpeciesCollection(species);
    String speciesName = speciesCollection.getSpecies(post.speciesID).name;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 8,
          child: Column(
        children: [
          ListTile(
              leading: UserAvatar(userID: post.userID),
              trailing: const Icon(Icons.more_vert),
              title: Text(post.title,
                  style: Theme.of(context).textTheme.titleLarge),
              subtitle: Text(post.date.toString()),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Post: ${post.body}')),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Location: $locationName')),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Species: $speciesName')),
          ),
          const SizedBox(height: 10)
        ],
      )),
    );
  }
}
