import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invasive_species_finder/components/user_labeled_avatar.dart';
import 'package:invasive_species_finder/data_model/user_db.dart';

import '../../../data_model/forum_post_db.dart';
import '../../data_model/location_db.dart';
import '../../data_model/species_db.dart';
import 'edit_post_view.dart';
import 'forum_item_actions.dart';

enum PostActions { edit, delete }

/// Displays a news item given its ID.
class ForumItemView extends ConsumerWidget {
  const ForumItemView({
    super.key,
    required this.postID,
  });

  final String postID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserDB userDB = ref.watch(userDBProvider);
    final ForumPostDB postsDB = ref.watch(forumPostDBProvider);
    final LocationDB locationDB = ref.watch(locationDBProvider);
    final SpeciesDB speciesDB = ref.watch(speciesDBProvider);
    ForumPostData data = postsDB.getPosts(postID);
    String imagePath = data.imagePath;
    String title = data.title;
    String body = data.body;
    String date = data.date;
    String lastUpdate = data.lastUpdate;
    String locationID = data.locationID;
    String userID = data.userID;
    String speciesID = data.speciesID;

    String locationName = locationDB.getLocations(locationID).name;
    String userName = userDB.getUser(userID).name;
    String speciesName = speciesDB.getSpecies(speciesID).name;
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
