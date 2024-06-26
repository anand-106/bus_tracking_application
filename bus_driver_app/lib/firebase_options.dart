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
    storageBucket: 'bus-tracking-app-5d78e.appspot.com',
    measurementId: 'G-XE5JLS7ZSH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCL4C3ZavAf7I-p0pPlqTbR7oAh578plX8',
    appId: '1:359209675456:android:ba2c74b223a9a3c8c89b25',
    messagingSenderId: '359209675456',
    projectId: 'bus-tracking-app-5d78e',
    storageBucket: 'bus-tracking-app-5d78e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDLUJV1VbTJ3xJCNH4uAe44DJ0znDPFf0U',
    appId: '1:359209675456:ios:2c8ad4a66196fc6dc89b25',
    messagingSenderId: '359209675456',
    projectId: 'bus-tracking-app-5d78e',
    storageBucket: 'bus-tracking-app-5d78e.appspot.com',
    iosBundleId: 'com.example.busTracking',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDLUJV1VbTJ3xJCNH4uAe44DJ0znDPFf0U',
    appId: '1:359209675456:ios:0cb36a714283740bc89b25',
    messagingSenderId: '359209675456',
    projectId: 'bus-tracking-app-5d78e',
    storageBucket: 'bus-tracking-app-5d78e.appspot.com',
    iosBundleId: 'com.example.busTracking.RunnerTests',
  );
}
