import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invasive_species_finder/features/forum/domain/forum_post_collection.dart';

import '../../common/all_data_provider.dart';
import '../../common/isf_error.dart';
import '../../common/isf_loading.dart';
import '../domain/forum_post.dart';
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
  build(BuildContext context, WidgetRef ref){
    final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
    return asyncAllData.when(
      data: (allData) => _build(
        context: context,
        currentUserID: allData.currentUserID,
        posts: allData.posts
      ),
      error: (err, stack) => ISFError(err.toString(), stack.toString()),
      loading: () => const ISFLoading(),
    );
  }

  _build({
    required BuildContext context,
    required String currentUserID,
    required List<ForumPost> posts}) {
    ForumPostCollection postCollection = ForumPostCollection(posts);
    List<String> postIDs = postCollection.getPostIDs();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.restorablePushNamed(context, AddPost.routeName);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
    );
  }
}
