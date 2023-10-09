import 'package:flutter/material.dart';

import '../../sample_feature/sample_item.dart';

/// Displays a list of Categories.
class ListCategoryView extends StatelessWidget {
  const ListCategoryView({
    super.key,
    this.items = const [SampleItem(1), SampleItem(2), SampleItem(3)],
  });

  final List<SampleItem> items;
  final String title = 'Categories';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: ListView(shrinkWrap: true, children: [
        SizedBox(
          height: 200,
          child: Card(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Image.asset(
                  'assets/images/animal.png',
                  fit: BoxFit.cover,
                ),
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Animals',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          )),
        ),
        SizedBox(
          height: 200,
          child: Card(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Image.asset(
                  'assets/images/plant.png',
                  fit: BoxFit.cover,
                ),
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Plants',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          )),
        ),
        SizedBox(
          height: 200,
          child: Card(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Image.asset(
                  'assets/images/insect.png',
                  fit: BoxFit.cover,
                ),
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Insects',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          )),
        ),
      ]),
    );
  }
}
