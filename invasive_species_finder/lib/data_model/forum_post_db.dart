import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

/// The data associated with posts.
class ForumPostData {
  ForumPostData({
    required this.id,
    required this.imagePath,
    required this.title,
    required this.body,
    required this.date,
    required this.userID,
    required this.locationID,
    required this.speciesID,
    required this.lastUpdate,
  });

  String id;
  String imagePath;
  String title;
  String body;
  String date;
  String userID;
  String locationID;
  String speciesID;
  String lastUpdate;
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
        imagePath: "assets/images/animal.png",
        title: 'Found species001',
        body: 'This invasive species was found at location001.',
        lastUpdate: '11/15/22',
        date: '11/15/22'),
    ForumPostData(
        id: 'forum-post-002',
        userID: 'user-002',
        locationID: 'location-002',
        speciesID: 'species-002',
        imagePath: 'assets/images/insect.png',
        title: 'Found species002',
        body: 'some description',
        lastUpdate: '11/12/22',
        date: '11/10/22'),
    ForumPostData(
        id: 'forum-post-003',
        userID: 'user-001',
        locationID: 'location-003',
        speciesID: 'species-003',
        imagePath: 'assets/images/plant.png',
        title: 'Found species003',
        body: 'description',
        lastUpdate: '11/25/22',
        date: '11/20/22'),
    ForumPostData(
        id: 'forum-post-004',
        userID: 'user-003',
        locationID: 'location-004',
        speciesID: 'species-003',
        imagePath: 'assets/images/plant.png',
        title: 'Found species001',
        body: "Some information",
        lastUpdate: '11/30/22' ,
        date: '11/25/22'),
    ForumPostData(
        id: 'forum-post-005',
        userID: 'user-001',
        locationID: 'location-005',
        speciesID: 'species-002',
        imagePath: 'assets/images/insect.png',
        title: 'Help wanted',
        body: "message",
        lastUpdate: '11/30/22',
        date: '11/25/22'),
    ForumPostData(
        id: 'form-post-006',
        userID: 'user-002',
        locationID: 'location-006',
        speciesID: 'species-001',
        imagePath: 'assets/images/animal.png',
        title: 'Pest Alert: Aphids',
        body: "10 gardens with Aphid pest observations this week",
        lastUpdate: '12/05/22',
        date: '11/30/22'),
  ];

  void addPost({
    required String title,
    required String body,
    required String date,
    required String imageFileName,
    required String locationID,
    required String userID,
    required String speciesID}) {
    String id = 'forum-post-${(_posts.length + 1).toString().padLeft(3, '0')}';
    String imagePath = 'assets/images/$imageFileName';
    String lastUpdate = DateFormat.yMd().format(DateTime.now());
    ForumPostData data = ForumPostData(
        id: id,
        imagePath: imagePath,
        title: title,
        body: body,
        date: date,
        lastUpdate: lastUpdate,
        userID: userID,
        locationID: locationID,
        speciesID: speciesID);
    _posts.add(data);
  }

  void updatePost({
    required String id,
    required String title,
    required String body,
    required String date,
    required String imagePath,
    required String locationID,
    required String userID,
    required String speciesID}) {
    _posts.removeWhere((data) => data.id == id);
    String lastUpdate = DateFormat.yMd().format(DateTime.now());
    ForumPostData data = ForumPostData(
        id: id,
        imagePath: imagePath,
        title: title,
        body: body,
        lastUpdate: lastUpdate,
        date: date,
        userID: userID,
        locationID: locationID,
        speciesID: speciesID);
    _posts.add(data);
  }



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
