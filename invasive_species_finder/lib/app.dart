import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invasive_species_finder/features/camera/presentation/take_picture_page.dart';
import 'package:invasive_species_finder/features/forum/presentation/add_post.dart';
import 'package:invasive_species_finder/features/forum/presentation/edit_post_view.dart';
import 'package:invasive_species_finder/features/forum/presentation/forum_view.dart';
import 'package:invasive_species_finder/features/help/presentation/help_view.dart';
import 'package:invasive_species_finder/features/help/presentation/help_view_local.dart';
import 'package:invasive_species_finder/features/location/presentation/map_page.dart';
import 'package:invasive_species_finder/features/message/presentation/messages_view.dart';
import 'package:invasive_species_finder/features/page_not_found/presentation/page_not_found_view.dart';
import 'package:invasive_species_finder/features/species/presentation/list_category_view.dart';
import 'package:invasive_species_finder/features/user/presentation/posts_view.dart';

import 'features/authentication/presentation/forgot_password_view.dart';
import 'features/authentication/presentation/verify_email_view.dart';
import 'features/settings/presentation/settings_view.dart';

import 'features/authentication/presentation/signin_view.dart';
import 'features/home/presentation/home_view.dart';
import 'features/camera/presentation/camera_page.dart';

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
              case SignInView.routeName:
                return const SignInView();
              case VerifyEmailView.routeName:
                return const VerifyEmailView();
              case ForgotPasswordView.routeName:
                return const ForgotPasswordView();
              case SettingsView.routeName:
                return const SettingsView();
              case HomeView.routeName:
                return const HomeView();
              case HelpView.routeName:
                return const HelpView();
              case HelpViewLocal.routeName:
                return const HelpViewLocal();
              case PostsView.routeName:
                return const PostsView();
              case CameraPage.routeName:
                return const CameraPage();
              case TakePicturePage.routeName:
                return const TakePicturePage();
              case MapPage.routeName:
                return MapPage();
              case ForumView.routeName:
                return const ForumView();
              case MessagesView.routeName:
                return const MessagesView();
              case AddPost.routeName:
                return AddPost();
              case EditPostView.routeName:
                return EditPostView();
                case ListCategoryView.routeName:
                  return const ListCategoryView();
              default:
                return const PageNotFoundView();
            }
          },
        );
      },
    );
  }
}
