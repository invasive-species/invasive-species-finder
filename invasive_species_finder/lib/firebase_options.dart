// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDgZYir31A542nfH_Eexvj7sxnh67jIWhk',
    appId: '1:552640942465:web:5833d517716704ca86d880',
    messagingSenderId: '552640942465',
    projectId: 'invasive-species-finder',
    authDomain: 'invasive-species-finder.firebaseapp.com',
    storageBucket: 'invasive-species-finder.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBQRd7vI_YgxlyY-mTiOYKnjeKhR4i6Dng',
    appId: '1:552640942465:android:d3bff393f9c4ff2286d880',
    messagingSenderId: '552640942465',
    projectId: 'invasive-species-finder',
    storageBucket: 'invasive-species-finder.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDh1ZrVUIlwL-1tH2P3HKlGhx34A8Rxw3I',
    appId: '1:552640942465:ios:5ca86ff9daddac4186d880',
    messagingSenderId: '552640942465',
    projectId: 'invasive-species-finder',
    storageBucket: 'invasive-species-finder.appspot.com',
    iosBundleId: 'com.example.invasiveSpeciesFinder',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDh1ZrVUIlwL-1tH2P3HKlGhx34A8Rxw3I',
    appId: '1:552640942465:ios:100d1b758c3aef0686d880',
    messagingSenderId: '552640942465',
    projectId: 'invasive-species-finder',
    storageBucket: 'invasive-species-finder.appspot.com',
    iosBundleId: 'com.example.invasiveSpeciesFinder.RunnerTests',
  );
}