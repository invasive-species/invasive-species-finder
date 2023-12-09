import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invasive_species_finder/features/location/presentation/map_page.dart';
import 'package:invasive_species_finder/features/message/presentation/message_page.dart';

import '../../common/all_data_provider.dart';
import '../../common/drawer_view.dart';
import '../../common/isf_error.dart';
import '../../common/isf_loading.dart';
import '../../forum/domain/forum_post.dart';
import '../../forum/presentation/forum_view.dart';
import '../../help/presentation/help_button.dart';
import '../../species/domain/species.dart';
import '../../species/presentation/list_category_view.dart';
import '../../camera/presentation/camera_page.dart';

/// Top-level Layout for all of the "Home" related
class HomeView extends ConsumerStatefulWidget {
  const HomeView({
    super.key,
  });

  static const routeName = '/home';

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context){
    final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
    return asyncAllData.when(
      data: (allData) => _build(
        context: context,
        currentUserID: allData.currentUserID,
        posts: allData.posts,
        species: allData.species),
      error: (err, stack) => ISFError(err.toString(), stack.toString()),
      loading: () => const ISFLoading(),
    );
  }

  Widget _build({
    required BuildContext context,
    required String currentUserID,
    required List<ForumPost> posts,
    required List<Species> species}) {

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
        'body': const MessagePage(),
        'navItem': const BottomNavigationBarItem(
          label: 'Messages',
          icon: Icon(Icons.message),
        ),
      },
      4: {
        'title': const Text('Map'),
        'body': MapPage(),
        'navItem': const BottomNavigationBarItem(
          label: 'Map',
          icon: Icon(Icons.map),
        ),
      }
    };

    return Scaffold(
      drawer: const DrawerView(),
      appBar: AppBar(
        title: pages[_selectedIndex]['title'],
        actions: const [HelpButton(routeName: HomeView.routeName)],
      ),
      body: pages[_selectedIndex]['body'],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // needed when more than 3 items
        items: [
          pages[0]['navItem'],
          pages[1]['navItem'],
          pages[2]['navItem'],
          pages[3]['navItem'],
          pages[4]['navItem'],
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
