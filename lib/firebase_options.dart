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
    apiKey: 'AIzaSyAZ-Le6IWSEgSxiHKmGsBcY0rYGyIxJKsY',
    appId: '1:669991550893:web:3391d314df840523c66b24',
    messagingSenderId: '669991550893',
    projectId: 'abm-mobile-5acef',
    authDomain: 'abm-mobile-5acef.firebaseapp.com',
    databaseURL: 'https://abm-mobile-5acef-default-rtdb.firebaseio.com',
    storageBucket: 'abm-mobile-5acef.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCqNZVLuceNpganJ3ivwdUR5GxT6jnfiOM',
    appId: '1:669991550893:android:abaca1024f26bbe3c66b24',
    messagingSenderId: '669991550893',
    projectId: 'abm-mobile-5acef',
    databaseURL: 'https://abm-mobile-5acef-default-rtdb.firebaseio.com',
    storageBucket: 'abm-mobile-5acef.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCJ1GMncSb5QFTeS7G3f_mgz4fYA7VLA30',
    appId: '1:669991550893:ios:94685ef2344500d7c66b24',
    messagingSenderId: '669991550893',
    projectId: 'abm-mobile-5acef',
    databaseURL: 'https://abm-mobile-5acef-default-rtdb.firebaseio.com',
    storageBucket: 'abm-mobile-5acef.firebasestorage.app',
    iosBundleId: 'com.example.abm',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCJ1GMncSb5QFTeS7G3f_mgz4fYA7VLA30',
    appId: '1:669991550893:ios:94685ef2344500d7c66b24',
    messagingSenderId: '669991550893',
    projectId: 'abm-mobile-5acef',
    databaseURL: 'https://abm-mobile-5acef-default-rtdb.firebaseio.com',
    storageBucket: 'abm-mobile-5acef.firebasestorage.app',
    iosBundleId: 'com.example.abm',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAZ-Le6IWSEgSxiHKmGsBcY0rYGyIxJKsY',
    appId: '1:669991550893:web:a429f673f54d9089c66b24',
    messagingSenderId: '669991550893',
    projectId: 'abm-mobile-5acef',
    authDomain: 'abm-mobile-5acef.firebaseapp.com',
    databaseURL: 'https://abm-mobile-5acef-default-rtdb.firebaseio.com',
    storageBucket: 'abm-mobile-5acef.firebasestorage.app',
  );

}