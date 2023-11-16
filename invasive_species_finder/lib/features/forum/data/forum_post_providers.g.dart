// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forum_post_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$forumPostDatabaseHash() => r'e39235e7be3ba8a833502e6a8439e5b40cc7d80f';

/// See also [forumPostDatabase].
@ProviderFor(forumPostDatabase)
final forumPostDatabaseProvider =
    AutoDisposeProvider<ForumPostDatabase>.internal(
  forumPostDatabase,
  name: r'forumPostDatabaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$forumPostDatabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ForumPostDatabaseRef = AutoDisposeProviderRef<ForumPostDatabase>;
String _$forumPostsHash() => r'406ad25d8e6626dc724032e8ae5fe3bef28408a5';

/// See also [forumPosts].
@ProviderFor(forumPosts)
final forumPostsProvider = AutoDisposeStreamProvider<List<ForumPost>>.internal(
  forumPosts,
  name: r'forumPostsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$forumPostsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ForumPostsRef = AutoDisposeStreamProviderRef<List<ForumPost>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
