import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invasive_species_finder/features/forum/domain/forum_post_db.dart';

import '../../common/drawer_view.dart';
import '../../forum/data/forum_post_providers.dart';
import '../../help/presentation/help_button.dart';
import '../data/post_providers.dart';
import 'post_card_view.dart';

const pageSpecification = '''
# Users Page Specification

## Motivation/Goals

We want this page to facilitate the creation of a local "Community of Practice".

On the other hand, we want to preserve privacy. 

So, we will need to ability for members to manage how much of their information is made available to others. 

## Contents

Since people can be part of more than one Chapter, we might have to have a top-level card or maybe an expandable card? 

It should list the "public profile" for a member, which could include their username, the gardens they own, maybe something about their crops.  

## Actions 

It should be possible to message members.  This seems crucial to create a community of practice.

If folks can be messaged, then it should also be possible for a member to block messages from another person. 

Maybe you can request "messaging privilege" or something from another member, so by default you can't message others? 

''';

/// Displays User information.
class PostsView extends ConsumerWidget {
  const PostsView({
    super.key,
  });
  final String title = 'Posts';
  static const routeName = '/posts';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String currentUserID = ref.watch(currentUserIDProvider);
    final ForumPostDB postsDB = ref.watch(forumPostDBProvider);
    return Scaffold(
      drawer: const DrawerView(),
      appBar: AppBar(
        title: const Text('Posts'),
        actions: const [HelpButton(routeName: PostsView.routeName)],
      ),
      body: ListView(children: [
        ...postsDB
            .getAssociatedPostIDs(currentUserID)
            .map((postID) => PostCardView(postID: postID))
      ]),
      bottomNavigationBar: BottomNavigationBar(
        // type: BottomNavigationBarType.fixed, // needed when more than 3 items
        items: const [
          BottomNavigationBarItem(
            label: 'Filter',
            icon: Icon(Icons.filter_list),
          ),
          BottomNavigationBarItem(
            label: 'Sort',
            icon: Icon(Icons.sort),
          ),
        ],
      ),
    );
  }
}