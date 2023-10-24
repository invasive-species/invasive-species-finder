import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invasive_species_finder/data_model/forum_post_db.dart';

import 'add_post.dart';
import 'forum_item_view.dart';

/// Displays a list of Gardens.
class ForumView extends ConsumerWidget {
  const ForumView({
    super.key,
  });

  final String title = 'Forum Posts';
  static const routeName = '/forum';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ForumPostDB postsDB = ref.watch(forumPostDBProvider);
    List<String> postIDs = postsDB.getPostIDs();
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: (postIDs.isEmpty)
              ? const Align(
              alignment: Alignment.center,
              child: Text("No forum posts yet!"))
              : ListView(children: [
            ...postIDs
                .map((postID) => ForumItemView(postID: postID))
                .toList()
          ])),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.restorablePushNamed(context, AddPost.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
