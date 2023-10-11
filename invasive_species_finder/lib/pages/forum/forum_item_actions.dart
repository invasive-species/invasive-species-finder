import 'package:flutter/material.dart';

class ForumItemActions extends StatelessWidget {
  const ForumItemActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: const Icon(Icons.more_vert),
        itemBuilder: (context) {
          return [
            const PopupMenuItem<int>(
              value: 0,
              child: Text("See details"),
            ),
            const PopupMenuItem<int>(
              value: 1,
              child: Text("Remove from your forum display"),
            ),
          ];
        },
        onSelected: (value) {
          if (value == 0) {
            // print("My account menu is selected.");
          } else if (value == 1) {
            // print("Settings menu is selected.");
          } else if (value == 2) {
            // print("Logout menu is selected.");
          }
        });
  }
}
