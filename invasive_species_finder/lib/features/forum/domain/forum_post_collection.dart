import 'forum_post.dart';

class ForumPostCollection {
  ForumPostCollection(posts) : _posts = posts;

  final List<ForumPost> _posts;

  int size() {
    return _posts.length;
  }

  ForumPost getPost(String postID) {
    return _posts.firstWhere((data) => data.id == postID);
  }

  List<String> getPostIDs() {
    return _posts.map((data) => data.id).toList();
  }

  List<String> getAssociatedPostIDs({String? userID}) {
    if (userID != null) {
      return getPostIDs()
          .where((postID) => _userIsAssociated(postID, userID))
          .toList();
    }
    return [];
  }

  bool _userIsAssociated(String postID, String userID) {
    ForumPost data = getPost(postID);
    return ((data.userID == userID));
  }
}
