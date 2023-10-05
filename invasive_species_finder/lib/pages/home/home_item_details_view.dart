import 'package:flutter/material.dart';

/// Displays detailed information about a SampleItem.
class HomeItemDetailsView extends StatelessWidget {
  const HomeItemDetailsView({super.key});

  static const routeName = '/home/item_details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('home'),
      ),
      body: const Center(
        child: Text('More Information Here'),
      ),
    );
  }
}
