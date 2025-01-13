// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyAcoBYq-sXX0iRZ1fmx6jYRa_Rdi0RPyrw',
    appId: '1:1003862755047:web:c47fac2029b877d37ec442',
    messagingSenderId: '1003862755047',
    projectId: 'authentication-6f59b',
    authDomain: 'authentication-6f59b.firebaseapp.com',
    storageBucket: 'authentication-6f59b.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBoTW3snSEirlhcPLTVfhRBTifUG3rOxlM',
    appId: '1:1003862755047:android:03d25175632002667ec442',
    messagingSenderId: '1003862755047',
    projectId: 'authentication-6f59b',
    storageBucket: 'authentication-6f59b.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAJlzqHpNCv-xJsSeltTZq7mUVdMAR92YM',
    appId: '1:1003862755047:ios:ae9be15590dab2697ec442',
    messagingSenderId: '1003862755047',
    projectId: 'authentication-6f59b',
    storageBucket: 'authentication-6f59b.firebasestorage.app',
    iosBundleId: 'com.example.flutterproject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAJlzqHpNCv-xJsSeltTZq7mUVdMAR92YM',
    appId: '1:1003862755047:ios:ae9be15590dab2697ec442',
    messagingSenderId: '1003862755047',
    projectId: 'authentication-6f59b',
    storageBucket: 'authentication-6f59b.firebasestorage.app',
    iosBundleId: 'com.example.flutterproject',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAcoBYq-sXX0iRZ1fmx6jYRa_Rdi0RPyrw',
    appId: '1:1003862755047:web:823f2d73b73357a07ec442',
    messagingSenderId: '1003862755047',
    projectId: 'authentication-6f59b',
    authDomain: 'authentication-6f59b.firebaseapp.com',
    storageBucket: 'authentication-6f59b.firebasestorage.app',
  );
}
