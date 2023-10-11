import 'package:flutter/material.dart';
import '../../data_model/forum_post_db.dart';
import '../../data_model/user_db.dart';
import '../../components/user_avatar.dart';

class PostCardView extends StatelessWidget {
  const PostCardView({Key? key, required this.postID}) : super(key: key);

  final String postID;

  @override
  Widget build(BuildContext context) {
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
