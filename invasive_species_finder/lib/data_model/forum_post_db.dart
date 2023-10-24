import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The data associated with posts.
class ForumPostData {
  ForumPostData({
    required this.id,
    required this.icon,
    required this.title,
    required this.body,
    required this.date,
    required this.userID,
    required this.locationID,
    required this.speciesID,
  });

  String id;
  IconData icon;
  String title;
  String body;
  String date;
  String userID;
  String locationID;
  String speciesID;
}

/// Provides access to and operations on all defined users.
class ForumPostDB {
  ForumPostDB(this.ref);

  final ProviderRef<ForumPostDB> ref;
  final List<ForumPostData> _posts = [
    ForumPostData(
        id: 'forum-post-001',
        userID: 'user-001',
        locationID: 'location-001',
        speciesID: 'species-001',
        icon: Icons.severe_cold,
        title: 'Found species001',
        body: 'This invasive species was found at location001.',
        date: '11/15/22'),
    ForumPostData(
        id: 'forum-post-002',
        userID: 'user-002',
        locationID: 'location-002',
        speciesID: 'species-002',
        icon: Icons.image_search,
        title: 'Found species002',
        body: 'some description',
        date: '11/10/22'),
    ForumPostData(
        id: 'forum-post-003',
        userID: 'user-001',
        locationID: 'location-003',
        speciesID: 'species-003',
        icon: Icons.group_add,
        title: 'Found species003',
        body: 'description',
        date: '11/20/22'),
    ForumPostData(
        id: 'forum-post-004',
        userID: 'user-003',
        locationID: 'location-004',
        speciesID: 'species-003',
        icon: Icons.water_drop,
        title: 'Found species001',
        body: "Some information",
        date: '11/25/22'),
    ForumPostData(
        id: 'forum-post-005',
        userID: 'user-001',
        locationID: 'location-005',
        speciesID: 'species-002',
        icon: Icons.yard_outlined,
        title: 'Help wanted',
        body: "message",
        date: '11/25/22'),
    ForumPostData(
        id: 'form-post-006',
        userID: 'user-002',
        locationID: 'location-006',
        speciesID: 'species-001',
        icon: Icons.pest_control,
        title: 'Pest Alert: Aphids',
        body: "10 gardens with Aphid pest observations this week",
        date: '11/30/22'),
  ];

  List<String> getPostIDs() {
    return _posts.map((data) => data.id).toList();
  }

  ForumPostData getPosts(postID) {
    return _posts.firstWhere((data) => data.id == postID);
  }

  List<String> getAssociatedPostIDs(String userID) {
    return getPostIDs()
        .where((postID) => getPosts(postID).userID == userID)
        .toList();
  }
}

final forumPostDBProvider = Provider<ForumPostDB>((ref) {
  return ForumPostDB(ref);
});
