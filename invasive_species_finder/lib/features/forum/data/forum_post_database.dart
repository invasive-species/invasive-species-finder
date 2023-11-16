import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invasive_species_finder/repositories/firestore/firestore_path.dart';
import 'package:invasive_species_finder/repositories/firestore/firestore_service.dart';

import '../domain/forum_post.dart';

class ForumPostDatabase{
  ForumPostDatabase(this.ref);

  final ProviderRef<ForumPostDatabase> ref;

  final _service = FirestoreService.instance;

  Stream<List<ForumPost>> watchForumPosts() => _service.watchCollection(
      path: FirestorePath.posts(),
      builder: (data, documentId) => ForumPost.fromJson(data!));

  Stream<ForumPost> watchForumPost(String forumPostId) => _service.watchDocument(
      path: FirestorePath.post(forumPostId),
      builder: (data, documentId) => ForumPost.fromJson(data!));

  Future<List<ForumPost>> fetchForumPosts() => _service.fetchCollection(
      path: FirestorePath.posts(),
      builder: (data, documentId) => ForumPost.fromJson(data!));

  Future<ForumPost> fetchForumPost(String forumPostId) => _service.fetchDocument(
      path: FirestorePath.post(forumPostId),
      builder: (data, documentId) => ForumPost.fromJson(data!));

  Future<void> setForumPost(ForumPost forumPost) => _service.setData(
      path: FirestorePath.post(forumPost.id), data: forumPost.toJson());

  Future<void> setForumPostDelayed(ForumPost forumPost) => Future.delayed(
      const Duration(milliseconds: 2000),
      () => _service.setData(
          path: FirestorePath.post(forumPost.id), data: forumPost.toJson()));

  Future<void> setForumPostError(ForumPost forumPost) =>
      Future.delayed(const Duration(milliseconds: 2000), () => throw Error());

  Future<void> deleteForumPost(ForumPost forumPost) =>
      _service.deleteData(path: FirestorePath.post(forumPost.id));
}
