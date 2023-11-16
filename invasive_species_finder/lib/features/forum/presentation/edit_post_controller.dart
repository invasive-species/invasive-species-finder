import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/foundation.dart';

import '../data/forum_post_database.dart';
import '../domain/forum_post.dart';
import '../data/forum_post_providers.dart';

part 'edit_post_controller.g.dart';

@riverpod
class EditPostController extends _$EditPostController {
  bool mounted = true;

  @override
  FutureOr<void> build() {
    ref.onDispose(() => mounted = false);
    state = const AsyncData(null);
  }

  Future<void> updatePost({
    required ForumPost post,
    required VoidCallback onSuccess,
  }) async {
    state = const AsyncLoading();
    ForumPostDatabase postDatabase = ref.watch(forumPostDatabaseProvider);
    final newState =
        await AsyncValue.guard(() => postDatabase.setForumPost(post));
    if (mounted) {
      state = newState;
    }
    if (!state.hasError) {
      onSuccess();
    }
  }

  Future<void> deletePost({
    required ForumPost post,
    required VoidCallback onSuccess,
  }) async {
    state = const AsyncLoading();
    ForumPostDatabase postDatabase = ref.watch(forumPostDatabaseProvider);
    final newState =
        await AsyncValue.guard(() => postDatabase.deleteForumPost(post));
    if (mounted) {
      state = newState;
    }
    if (!state.hasError) {
      onSuccess();
    }
  }
}
