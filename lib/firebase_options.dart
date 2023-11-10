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
    apiKey: 'AIzaSyAJzHFJtL6fkoUVepEPA7T7O-qvao7xctY',
    appId: '1:1099060023076:web:672026574f43cca9ac6db1',
    messagingSenderId: '1099060023076',
    projectId: 'thunter-4ba22',
    authDomain: 'thunter-4ba22.firebaseapp.com',
    storageBucket: 'thunter-4ba22.appspot.com',
    measurementId: 'G-WNCQLGWJYK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA-f8U182NCss7IPvAA0TDAeSrMZ3mVabg',
    appId: '1:1099060023076:android:f5d2ba9330daff7cac6db1',
    messagingSenderId: '1099060023076',
    projectId: 'thunter-4ba22',
    storageBucket: 'thunter-4ba22.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCtqOI_hD8XxLwOmGm4YWr3L1grmkzuViA',
    appId: '1:1099060023076:ios:4972581c2fa58be9ac6db1',
    messagingSenderId: '1099060023076',
    projectId: 'thunter-4ba22',
    storageBucket: 'thunter-4ba22.appspot.com',
    iosBundleId: 'com.example.initiator2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCtqOI_hD8XxLwOmGm4YWr3L1grmkzuViA',
    appId: '1:1099060023076:ios:5c820f095b7f6794ac6db1',
    messagingSenderId: '1099060023076',
    projectId: 'thunter-4ba22',
    storageBucket: 'thunter-4ba22.appspot.com',
    iosBundleId: 'com.example.initiator2.RunnerTests',
  );
}
