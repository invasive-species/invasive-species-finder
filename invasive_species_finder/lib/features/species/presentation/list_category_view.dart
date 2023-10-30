import 'package:flutter/material.dart';

import 'list_category_item.dart';
import 'list_category_action.dart';

/// Displays a list of Categories.
class ListCategoryView extends StatelessWidget {
  const ListCategoryView({
    super.key,
  });

  final String title = 'Categories';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: ListView(shrinkWrap: true, children: [
        GestureDetector(
          onTap: () {
            navigateToDetailPage(context, "Animals");
          },
          child: const ListCategoryItem(
            imagePath: 'assets/images/animal.png',
            title: 'Animals',
          ),
        ),
        GestureDetector(
          onTap: () {
            navigateToDetailPage(context, "Plants");
          },
          child: const ListCategoryItem(
            imagePath: 'assets/images/plant.png',
            title: 'Plants',
          ),
        ),
        GestureDetector(
          onTap: () {
            navigateToDetailPage(context, "Insects");
          },
          child: const ListCategoryItem(
            imagePath: 'assets/images/insect.png',
            title: 'Insects',
          ),
        ),
      ]),
    );
  }
}
