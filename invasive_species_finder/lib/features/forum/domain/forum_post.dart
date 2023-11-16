import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'forum_post.freezed.dart';
part 'forum_post.g.dart';

@freezed
class ForumPost with _$ForumPost {
  const factory ForumPost({
    required String id,
    required String imagePath,
    required String title,
    required String body,
    required String date,
    required String userID,
    required String locationID,
    required String speciesID,
    required String lastUpdate,
  }) = _ForumPost;

  factory ForumPost.fromJson(Map<String, dynamic> json) =>
      _$ForumPostFromJson(json);

  // Test that the json file can be converted into entities.
  static Future<List<ForumPost>> checkInitialData() async {
    String content =
    await rootBundle.loadString("assets/initialData/posts.json");
    List<dynamic> initialData = json.decode(content);
    return initialData.map((jsonData) => ForumPost.fromJson(jsonData)).toList();
  }
}
