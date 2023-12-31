/*
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../forum/data/forum_post_providers.dart';

/// The data associated with users.
class UserData {
  UserData(
      {required this.id,
      required this.name,
      required this.email,
      required this.username,
      this.imagePath,
      required this.initials});

  String id;
  String name;
  String email;
  String username;
  String? imagePath;
  String initials;
}

/// Provides access to and operations on all defined users.
class UserDB {
  UserDB(this.ref);

  final ProviderRef<UserDB> ref;
  final List<UserData> _users = [
    UserData(
        id: 'user-001',
        name: 'John Deane',
        username: '@johndeane',
        email: 'johndeane@gmail.com',
        imagePath: 'assets/images/john.png',
        initials: 'JD'),
    UserData(
        id: 'user-002',
        name: 'Jesse Beck',
        username: '@jesse',
        email: 'jessebeck@gmail.com',
        imagePath: 'assets/images/john.png',
        initials: 'JB'),
    UserData(
        id: 'user-003',
        name: 'Joanne Amberg',
        username: '@joanne',
        email: 'joanne.amberg@gmail.com',
        initials: 'JA'),
    UserData(
        id: 'user-004',
        name: 'Philip Johnson',
        username: '@fiveoclockphil',
        email: 'johnson@hawaii.edu',
        initials: 'PJ'),
    UserData(
        id: 'user-005',
        name: 'Katie Amberg-Johnson',
        username: '@katiekai',
        email: 'katieambergjohnson@gmail.com',
        imagePath: 'assets/images/user-005.jpg',
        initials: 'KAJ')
  ];

  UserData getUser(String userID) {
    return _users.firstWhere((userData) => userData.id == userID);
  }

  String getUserID(String emailOrUsername) {
    return (emailOrUsername.startsWith('@'))
        ? _users.firstWhere((userData) => userData.username == emailOrUsername).id
        : _users.firstWhere((userData) => userData.email == emailOrUsername).id;
  }

  List<UserData> getUsers(List<String> userIDs) {
    return _users.where((userData) => userIDs.contains(userData.id)).toList();
  }

  List<String> getAllEmails() {
    return _users.map((userData) => userData.email).toList();
  }

  bool isUserEmail(String email) {
    List<String> emails = _users.map((userData) => userData.email).toList();
    return emails.contains(email);
  }

  // Return the userIDs of users who are in the same Chapter(s) as [userID].
  // First, get all of the chapterIDs that this [userID] is associated with.
  // Then build the set of all userIDs associated with the chapterIDs.
  List<String> getAssociatedPostIDs(String userID) {
    final postsDB = ref.read(forumPostDBProvider);
    List<String> postsIDs = postsDB.getAssociatedPostIDs(userID);
    return postsIDs;
  }
}

*/
