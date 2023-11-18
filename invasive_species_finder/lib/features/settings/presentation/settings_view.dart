
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invasive_species_finder/features/common/drawer_view.dart';

import '../data/settings_db.dart';


/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends ConsumerWidget {

  static const routeName = '/settings';

  const SettingsView({super.key});

  void updateThemeMode(ThemeMode? newThemeMode, WidgetRef ref) {
    if (newThemeMode == null) return;
    if (newThemeMode == ref.read(currentThemeModeProvider)) return;
    ref.read(currentThemeModeProvider.notifier).setThemeMode(newThemeMode);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(currentThemeModeProvider);
    return Scaffold(
      drawer: const DrawerView(),
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        // Glue the SettingsController to the theme selection DropdownButton.
        //
        // When a user selects a theme from the dropdown list, the
        // SettingsController is updated, which rebuilds the MaterialApp.
        child: DropdownButton<ThemeMode>(
          value: ref.read(currentThemeModeProvider),
          // Call the updateThemeMode method any time the user selects a theme.
          onChanged: (ThemeMode? newThemeMode) =>
          updateThemeMode(newThemeMode, ref),
          items: const [
            DropdownMenuItem(
              value: ThemeMode.system,
              child: Text('System Theme'),
            ),
            DropdownMenuItem(
              value: ThemeMode.light,
              child: Text('Light Theme'),
            ),
            DropdownMenuItem(
              value: ThemeMode.dark,
              child: Text('Dark Theme'),
            )
          ],
        ),
      ),
    );
  }
}
/*
final currentThemeProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.system;
});

final systemThemeDataProvider = FutureProvider<ThemeData>((ref) async{
  final themeStr = await rootBundle.loadString('assets/theme/appainter_theme_green1.json');
  final themeJson = jsonDecode(themeStr);
  return ThemeDecoder.decodeThemeData(themeJson)!;
});
*/
