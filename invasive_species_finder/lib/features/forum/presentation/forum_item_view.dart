import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invasive_species_finder/features/forum/domain/forum_post_collection.dart';
import 'package:invasive_species_finder/features/location/domain/location_collection.dart';
import 'package:invasive_species_finder/features/user/presentation/user_labeled_avatar.dart';

import '../../common/all_data_provider.dart';
import '../../common/isf_error.dart';
import '../../common/isf_loading.dart';
import '../../location/domain/location.dart';
import '../../species/domain/species.dart';
import '../../species/domain/species_collection.dart';
import '../domain/forum_post.dart';
import 'edit_post_view.dart';

enum PostActions { edit, delete }

/// Displays a news item given its ID.
class ForumItemView extends ConsumerWidget {
  const ForumItemView({
    super.key,
    required this.postID,
  });

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

  Widget _build({
    required BuildContext context,
    required String currentUserID,
    required List<ForumPost> posts,
    required List<Location> locations,
    required List<Species> species}) {
    ForumPostCollection postCollection = ForumPostCollection(posts);
    LocationCollection locationCollection = LocationCollection(locations);
    SpeciesCollection speciesCollection = SpeciesCollection(species);

    ForumPost data = postCollection.getPost(postID);
    String imagePath = data.imagePath;
    String title = data.title;
    String body = data.body;
    String date = data.date;
    String lastUpdate = data.lastUpdate;
    String locationID = data.locationID;
    String userID = data.userID;
    String speciesID = data.speciesID;

    String locationName = locationCollection.getLocation(locationID).name;
    String speciesName = speciesCollection.getSpecies(speciesID).name;
    AssetImage image = AssetImage(imagePath);
    return Card(
      elevation: 9,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            isThreeLine: true,
            title: Text(title),
            subtitle: Text('$body\n$locationName\n$speciesName\n$date\n'),
            trailing: PopupMenuButton<PostActions>(
              // Callback that sets the selected popup menu item.
              onSelected: (PostActions action) {
                if (action == PostActions.edit) {
                  Navigator.restorablePushNamed(
                      context, EditPostView.routeName,
                      arguments: postID);
                }
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<PostActions>>[
                const PopupMenuItem<PostActions>(
                  value: PostActions.edit,
                  child: Text('Edit'),
                ),
                const PopupMenuItem<PostActions>(
                  value: PostActions.delete,
                  child: Text('Delete'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 150.0,
            child: Image(
              image: image,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          UserLabeledAvatar(
              userID: userID,
              label: 'Owner',
              rightPadding: 10),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Last updated: $lastUpdate')),
        ],
      ),
    );
  }
}
