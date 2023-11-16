import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invasive_species_finder/features/authentication/presentation/signin_view.dart';
import 'package:invasive_species_finder/features/common/all_data_provider.dart';
import 'package:invasive_species_finder/features/common/isf_error.dart';
import 'package:invasive_species_finder/features/user/domain/user_collection.dart';
import 'package:invasive_species_finder/features/user/presentation/posts_view.dart';

import '../help/presentation/help_view.dart';
import '../home/presentation/home_view.dart';
import '../settings/presentation/settings_view.dart';
import '../user/domain/user.dart';
import '../user/presentation/user_avatar.dart';
import 'isf_loading.dart';


class DrawerView extends ConsumerWidget {
  const DrawerView({Key? key}) : super(key: key);

  @override
  build(BuildContext context, WidgetRef ref){
    final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
    return asyncAllData.when(
      data: (allData) => _build(
        context: context,
        currentUserID: allData.currentUserID,
        users: allData.users,
      ),
      error: (err, stack) => ISFError(err.toString(), stack.toString()),
      loading: () => const ISFLoading(),
    );
  }


  Widget _build (
      {required BuildContext context,
      required List<User> users,
      required String currentUserID}) {
    UserCollection userCollection = UserCollection(users);
    User user = userCollection.getUser(currentUserID);
    print(users);
    print(currentUserID);
    print(userCollection);
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user.name),
            accountEmail: Text(user.id),
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
            leading: const Icon(Icons.help_outline),
            title: const Text('Help'),
            onTap: () {
              Navigator.pushReplacementNamed(context, HelpView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pushReplacementNamed(context, SettingsView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sign out'),
            onTap: () {
              Navigator.pushReplacementNamed(context, SignInView.routeName);
            },
          ),
        ],
      ),
    );
  }
}
