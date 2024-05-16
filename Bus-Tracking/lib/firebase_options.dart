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
    apiKey: 'AIzaSyDPnrjXQoVRtgdmryAKHZP2iG79PzIK5eY',
    appId: '1:359209675456:web:1d1051d040d46f1ac89b25',
    messagingSenderId: '359209675456',
    projectId: 'bus-tracking-app-5d78e',
    authDomain: 'bus-tracking-app-5d78e.firebaseapp.com',
    databaseURL: 'https://bus-tracking-app-5d78e-default-rtdb.firebaseio.com',
    storageBucket: 'bus-tracking-app-5d78e.appspot.com',
    measurementId: 'G-XE5JLS7ZSH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCL4C3ZavAf7I-p0pPlqTbR7oAh578plX8',
    appId: '1:359209675456:android:8b90e57bf6a5b615c89b25',
    messagingSenderId: '359209675456',
    projectId: 'bus-tracking-app-5d78e',
    databaseURL: 'https://bus-tracking-app-5d78e-default-rtdb.firebaseio.com',
    storageBucket: 'bus-tracking-app-5d78e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDLUJV1VbTJ3xJCNH4uAe44DJ0znDPFf0U',
    appId: '1:359209675456:ios:52688defa20f5dc1c89b25',
    messagingSenderId: '359209675456',
    projectId: 'bus-tracking-app-5d78e',
    databaseURL: 'https://bus-tracking-app-5d78e-default-rtdb.firebaseio.com',
    storageBucket: 'bus-tracking-app-5d78e.appspot.com',
    iosBundleId: 'com.example.busTrackingDriver',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDLUJV1VbTJ3xJCNH4uAe44DJ0znDPFf0U',
    appId: '1:359209675456:ios:977fb83a896c5a7cc89b25',
    messagingSenderId: '359209675456',
    projectId: 'bus-tracking-app-5d78e',
    databaseURL: 'https://bus-tracking-app-5d78e-default-rtdb.firebaseio.com',
    storageBucket: 'bus-tracking-app-5d78e.appspot.com',
    iosBundleId: 'com.example.busTrackingDriver.RunnerTests',
  );
}