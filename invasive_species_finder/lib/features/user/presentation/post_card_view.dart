import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../forum/data/forum_post_providers.dart';
import '../../forum/domain/forum_post_db.dart';
import 'user_avatar.dart';

class PostCardView extends ConsumerWidget {
  const PostCardView({Key? key, required this.postID}) : super(key: key);

  final String postID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ForumPostDB postsDB = ref.watch(forumPostDBProvider);
    ForumPostData post = postsDB
        .getPosts(postID);

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
          const SizedBox(height: 10)
        ],
      )),
    );
  }
}
