import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invasive_species_finder/features/forum/domain/forum_post.dart';
import 'app.dart';
import 'features/location/domain/location.dart';
import 'features/message/domain/message.dart';
import 'features/species/domain/species.dart';
import 'features/user/domain/user.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseUIAuth.configureProviders([EmailAuthProvider()]);
  await verifyInitialData();
  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(const ProviderScope(child: MyApp()));
}

Future<bool> verifyInitialData() async {
  await Location.checkInitialData();
  await Message.checkInitialData();
  await Species.checkInitialData();
  await ForumPost.checkInitialData();
  await User.checkInitialData();
  return true;
}
