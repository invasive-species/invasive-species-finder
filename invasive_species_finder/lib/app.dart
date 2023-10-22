import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invasive_species_finder/pages/forum/forum_view.dart';
import 'package:invasive_species_finder/pages/help/help_view.dart';
import 'package:invasive_species_finder/pages/help/help_view_local.dart';
import 'package:invasive_species_finder/pages/map/map_page.dart';
import 'package:invasive_species_finder/pages/messages/messages_view.dart';
import 'package:invasive_species_finder/pages/page_not_found/page_not_found_view.dart';
import 'package:invasive_species_finder/pages/posts/posts_view.dart';

import 'settings/settings_view.dart';

import 'pages/signin/signin_view.dart';
import 'pages/signup/signup_view.dart';
import 'pages/home/home_view.dart';
import 'pages/camera/camera_page.dart';

/// The Widget that configures your application.
class MyApp extends ConsumerWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(currentThemeProvider);
    final systemTheme = ref.watch(systemThemeDataProvider);

    return MaterialApp(
      // Define a light and dark color theme. Then, read the user's
      // preferred ThemeMode (light, dark, or system default) from the
      // SettingsController to display the correct theme.
      theme: systemTheme.value,
      themeMode: currentTheme,
      darkTheme: ThemeData.dark(),

      // Define a function to handle named routes in order to support
      // Flutter web url navigation and deep linking.
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            switch (routeSettings.name) {
              case SigninView.routeName:
                return const SigninView();
              case SignupView.routeName:
                return const SignupView();
              case SettingsView.routeName:
                return const SettingsView();
              case HomeView.routeName:
                return HomeView();
              case HelpView.routeName:
                return const HelpView();
              case HelpViewLocal.routeName:
                return const HelpViewLocal();
              case PostsView.routeName:
                return const PostsView();
              case CameraPage.routeName:
                return const CameraPage();
              case MapPage.routeName:
                  return const MapPage();
              case ForumView.routeName:
                  return const ForumView();
              case MessagesView.routeName:
                  return const MessagesView();
              default:
                return const PageNotFoundView();
            }
          },
        );
      },
    );
  }
}
