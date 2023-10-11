import 'package:flutter/material.dart';
import 'package:invasive_species_finder/pages/posts/posts_view.dart';

import '../pages/home/home_view.dart';
import '../components/user_avatar.dart';
import '../data_model/user_db.dart';



class DrawerView extends StatelessWidget {
  const DrawerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserData user = userDB.getUser(currentUserID);
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user.name),
            accountEmail: Text(user.email),
            currentAccountPicture: UserAvatar(userID: user.id),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, HomeView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.feed),
            title: const Text('Posts'),
            onTap: () {
              Navigator.pushReplacementNamed(context, PostsView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sign out'),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'bad page');
            },
          ),
        ],
      ),
    );
  }
}
