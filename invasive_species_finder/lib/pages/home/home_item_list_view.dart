import 'package:flutter/material.dart';

import '../../settings/settings_view.dart';
import 'home_item.dart';
import 'home_item_details_view.dart';

/// Displays a list of HomeItems.
class HomeItemListView extends StatelessWidget {
  const HomeItemListView({
    super.key,
    this.items = const [HomeItem(1), HomeItem(2), HomeItem(3)],
  });

  static const routeName = '/';

  final List<HomeItem> items;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Number of items in a row
        childAspectRatio: 1.0, // Square aspect ratio
      ),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = items[index];
        return ListTile(
          title: Text('HomeItem ${item.id}'),
          leading: Container(
            width: 100, // Set your desired width
            height: 100, // Set your desired height
            child: const CircleAvatar(
              // Display the Flutter Logo image asset.
              foregroundImage: AssetImage('assets/images/vegetables.png'),
            ),
          ),
          onTap: () {
            // Navigate to the details page. If the user leaves and returns to
            // the app after it has been killed while running in the
            // background, the navigation stack is restored.
            Navigator.restorablePushNamed(
              context,
              HomeItemDetailsView.routeName,
            );
          },
        );
      },
    );
  }
}
