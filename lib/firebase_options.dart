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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDjMiYuVitfwa-DBGLeZ0F-mzEX5SSWsvU',
    appId: '1:278794950326:web:31f14533a0af2cbd683817',
    messagingSenderId: '278794950326',
    projectId: 'my-first-firebase-4c2e2',
    authDomain: 'my-first-firebase-4c2e2.firebaseapp.com',
    storageBucket: 'my-first-firebase-4c2e2.appspot.com',
    measurementId: 'G-KXRBKXTF9F',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCNjM9Z-_-3IGMfGhW1n6rBOZCy60o3R_w',
    appId: '1:278794950326:android:82db7999b19eadaf683817',
    messagingSenderId: '278794950326',
    projectId: 'my-first-firebase-4c2e2',
    storageBucket: 'my-first-firebase-4c2e2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAi8hHhjKRd5kUur_zZcJogqP8QR9J9phU',
    appId: '1:278794950326:ios:4ed81475f426f70f683817',
    messagingSenderId: '278794950326',
    projectId: 'my-first-firebase-4c2e2',
    storageBucket: 'my-first-firebase-4c2e2.appspot.com',
    iosClientId: '278794950326-9g01v6rlk5hgotcinrr21jt06se2llej.apps.googleusercontent.com',
    iosBundleId: 'firebasekaron.com.firebaseproject',
  );
}