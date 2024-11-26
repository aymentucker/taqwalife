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
    apiKey: 'AIzaSyClluwamauwF9025a3Y46E0IT-1SmuhioU',
    appId: '1:351065427920:web:aec716e03dfe4a69f773d5',
    messagingSenderId: '351065427920',
    projectId: 'taqwalife-islam',
    authDomain: 'taqwalife-islam.firebaseapp.com',
    storageBucket: 'taqwalife-islam.firebasestorage.app',
    measurementId: 'G-NLWS33XD16',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyASoyH--Grz2sA1UDXbiiB4b1Juibd3ECU',
    appId: '1:351065427920:android:0d61e9d5dc8d5ecaf773d5',
    messagingSenderId: '351065427920',
    projectId: 'taqwalife-islam',
    storageBucket: 'taqwalife-islam.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAo8VEWQ5Qiq3W8BON3bzWnwXDzdCjNLJQ',
    appId: '1:351065427920:ios:ce3412ac4070e1fbf773d5',
    messagingSenderId: '351065427920',
    projectId: 'taqwalife-islam',
    storageBucket: 'taqwalife-islam.firebasestorage.app',
    iosBundleId: 'com.designercastle.taqwalife',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAo8VEWQ5Qiq3W8BON3bzWnwXDzdCjNLJQ',
    appId: '1:351065427920:ios:ce3412ac4070e1fbf773d5',
    messagingSenderId: '351065427920',
    projectId: 'taqwalife-islam',
    storageBucket: 'taqwalife-islam.firebasestorage.app',
    iosBundleId: 'com.designercastle.taqwalife',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyClluwamauwF9025a3Y46E0IT-1SmuhioU',
    appId: '1:351065427920:web:1c4b4fc7209abcbaf773d5',
    messagingSenderId: '351065427920',
    projectId: 'taqwalife-islam',
    authDomain: 'taqwalife-islam.firebaseapp.com',
    storageBucket: 'taqwalife-islam.firebasestorage.app',
    measurementId: 'G-XK0ZK91W2M',
  );
}
