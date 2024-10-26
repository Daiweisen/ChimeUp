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
    apiKey: 'AIzaSyDscDijHBwMYvf7MyQi_GfNf5jEVAKdXDM',
    appId: '1:549272076745:web:fed886b866e80907cbe818',
    messagingSenderId: '549272076745',
    projectId: 'chimeup-8b7c7',
    authDomain: 'chimeup-8b7c7.firebaseapp.com',
    storageBucket: 'chimeup-8b7c7.appspot.com',
    measurementId: 'G-BS8GZYX9RY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyChKmi7HYKrlOjV87raDaUh5qndr7CaAs0',
    appId: '1:549272076745:android:5af62412afba9eb0cbe818',
    messagingSenderId: '549272076745',
    projectId: 'chimeup-8b7c7',
    storageBucket: 'chimeup-8b7c7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDyVog0l5h9BU4sYQMdINVS0UAM5vH8ZRM',
    appId: '1:549272076745:ios:93ca6f10595964cbcbe818',
    messagingSenderId: '549272076745',
    projectId: 'chimeup-8b7c7',
    storageBucket: 'chimeup-8b7c7.appspot.com',
    iosBundleId: 'com.example.chimeup',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDyVog0l5h9BU4sYQMdINVS0UAM5vH8ZRM',
    appId: '1:549272076745:ios:93ca6f10595964cbcbe818',
    messagingSenderId: '549272076745',
    projectId: 'chimeup-8b7c7',
    storageBucket: 'chimeup-8b7c7.appspot.com',
    iosBundleId: 'com.example.chimeup',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDscDijHBwMYvf7MyQi_GfNf5jEVAKdXDM',
    appId: '1:549272076745:web:70f3aa4a171f5869cbe818',
    messagingSenderId: '549272076745',
    projectId: 'chimeup-8b7c7',
    authDomain: 'chimeup-8b7c7.firebaseapp.com',
    storageBucket: 'chimeup-8b7c7.appspot.com',
    measurementId: 'G-8L45GRC1BP',
  );
}
