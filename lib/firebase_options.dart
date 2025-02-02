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
    apiKey: 'AIzaSyCJ1NMy2GcbDiE_NMVA7gOTqvi82czg03I',
    appId: '1:243924439958:web:7485572aaf4cd2a69ec3b7',
    messagingSenderId: '243924439958',
    projectId: 'shopsmart-ac2a3',
    authDomain: 'shopsmart-ac2a3.firebaseapp.com',
    storageBucket: 'shopsmart-ac2a3.appspot.com',
    measurementId: 'G-VPXVDBNNRB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAdWBvqHwR9OasvQ37HBeCMYIss6YSfLMQ',
    appId: '1:243924439958:android:ccbb90816f1b44279ec3b7',
    messagingSenderId: '243924439958',
    projectId: 'shopsmart-ac2a3',
    storageBucket: 'shopsmart-ac2a3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBuqx38fW0diwCaWnlT0OO91oHZ85rhMoc',
    appId: '1:243924439958:ios:c4252738374609a69ec3b7',
    messagingSenderId: '243924439958',
    projectId: 'shopsmart-ac2a3',
    storageBucket: 'shopsmart-ac2a3.appspot.com',
    iosBundleId: 'com.example.shopsmartUser',
  );
}
