
import 'package:invasive_species_finder/pages/forum/forum_view.dart';

import '../pages/home/home_view.dart';
import '../pages/posts/posts_view.dart';

/// Provides a help string (if available) for each page.
/// Pages are identified by their routeName because that's guaranteed to be unique.
class HelpDB {
  final Map<String, String> _helpMap = {
    HomeView.routeName: '''
# About the Home Page

some description

## My posts

list of the posts


        ''',
    PostsView.routeName: '''
# About the Post Page.

list of all posts of the user

       ''',
  };

  String getHelpString(String routeName) {
    return (_helpMap.containsKey(routeName)
        ? _helpMap[routeName]!
        : 'No help available');
  }
}

/// The singleton instance providing access to all user data for clients.
HelpDB helpDB = HelpDB();
