import 'package:flutter/material.dart';

import '../../pages/forum/forum_view.dart';
import '../../components/drawer_view.dart';
import '../../settings/settings_view.dart';
import '../list/list_category_view.dart';
import '../camera/camera_page.dart';

/// Top-level Layout for all of the "Home" related
class HomeView extends StatefulWidget {
  HomeView({
    super.key,
  });

  static const routeName = '/home';

  // This data structure will eventually become stateful and thus will
  // need to be moved into the state widget.
  final Map pages = {
    0: {
      'title': const Text('Lists'),
      'body': const ListCategoryView(),
      'navItem': const BottomNavigationBarItem(
        label: 'Lists',
        icon: Icon(Icons.list),
      ),
    },
    1: {
      'title': const Text('Forum'),
      'body': const ForumView(),
      'navItem': const BottomNavigationBarItem(
        label: 'Forum',
        icon: Icon(Icons.forum),
      ),
    },
    2: {
      'title': const Text('Camera'),
      'body': const CameraPage(),
      'navItem': const BottomNavigationBarItem(
        label: 'Camera',
        icon: Icon(Icons.camera_alt),
      ),
    },
    3: {
      'title': const Text('Messages'),
      'body': const Text('Place holder'),
      'navItem': const BottomNavigationBarItem(
        label: 'Messages',
        icon: Icon(Icons.message),
      ),
    },
    4: {
      'title': const Text('Map'),
      'body': const Text('Place holder'),
      'navItem': const BottomNavigationBarItem(
        label: 'Map',
        icon: Icon(Icons.map),
      ),
    },
  };

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerView(),
      appBar: AppBar(
        title: widget.pages[_selectedIndex]['title'],
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: widget.pages[_selectedIndex]['body'],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // needed when more than 3 items
        items: [
          widget.pages[0]['navItem'],
          widget.pages[1]['navItem'],
          widget.pages[2]['navItem'],
          widget.pages[3]['navItem'],
          widget.pages[4]['navItem'],
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
