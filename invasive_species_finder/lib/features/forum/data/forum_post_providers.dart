import 'package:invasive_species_finder/features/forum/data/forum_post_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/forum_post.dart';

part 'forum_post_providers.g.dart';

@riverpod
ForumPostDatabase forumPostDatabase(ForumPostDatabaseRef ref) {
  return ForumPostDatabase(ref);
}

@riverpod
Stream<List<ForumPost>> forumPosts(ForumPostsRef ref) {
  final database = ref.watch(forumPostDatabaseProvider);
  return database.watchForumPosts();
}

/*
final forumPostDBProvider = Provider<ForumPostDB>((ref) {
  return ForumPostDB(ref);
});
 */
