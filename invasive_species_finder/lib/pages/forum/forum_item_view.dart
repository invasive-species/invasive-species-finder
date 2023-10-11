import 'package:flutter/material.dart';
import 'package:invasive_species_finder/data_model/user_db.dart';

import '../../../data_model/forum_post_db.dart';
import '../../data_model/location_db.dart';
import '../../data_model/species_db.dart';
import 'forum_item_actions.dart';

/// Displays a news item given its ID.
class ForumItemView extends StatelessWidget {
  const ForumItemView({
    super.key,
    required this.postID,
  });

  final String postID;

  @override
  Widget build(BuildContext context) {
    ForumPostData data = postsDB.getPosts(postID);
    IconData icon = data.icon;
    String title = data.title;
    String body = data.body;
    String date = data.date;
    String locationID = data.locationID;
    String userID = data.userID;
    String speciesID = data.speciesID;

    String locationName = 'Location: ${locationDB.getLocations(locationID).name}';
    String userName = 'User: ${userDB.getUser(userID).name}';
    String speciesName = 'Species: ${speciesDB.getSpecies(speciesID).name}';
    String bodyPrefix = '$speciesName\n Found at $locationName \n by $userName ';
    return Column(children: [
      ListTile(
        leading: Icon(icon, color: Theme.of(context).primaryColor),
        title: Text('$title ($date)'),
        subtitle: Text('$bodyPrefix\n$body'),
        trailing: const ForumItemActions(),
      ),
      const Divider(),
    ]);
  }
}
