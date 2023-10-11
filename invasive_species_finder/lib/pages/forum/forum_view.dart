import 'package:flutter/material.dart';
import 'package:invasive_species_finder/data_model/forum_post_db.dart';

import 'forum_item_view.dart';

/// Displays a list of Gardens.
class ForumView extends StatelessWidget {
  const ForumView({
    super.key,
  });

  final String title = 'Forum Posts';

  @override
  Widget build(BuildContext context) {
    List<String> postIDs = postsDB.getPostIDs();
    return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: (postIDs.isEmpty)
            ? const Align(
            alignment: Alignment.center,
            child: Text("No news is good news!"))
            : ListView(children: [
          ...postIDs
              .map((postID) => ForumItemView(postID: postID))
              .toList()
        ]));
  }
}
