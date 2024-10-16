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
    apiKey: 'AIzaSyC6pnNNQyq5AEA1guD0jvctpfljg7lRDAo',
    appId: '1:975595926123:web:942a070d6ab698560b372e',
    messagingSenderId: '975595926123',
    projectId: 'calm-44eae',
    authDomain: 'calm-44eae.firebaseapp.com',
    storageBucket: 'calm-44eae.appspot.com',
    measurementId: 'G-HRVN526B2K',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyArKe2Pk0axGeWMchwERQlV8u1fJXwZGis',
    appId: '1:975595926123:android:160951104edeeef10b372e',
    messagingSenderId: '975595926123',
    projectId: 'calm-44eae',
    storageBucket: 'calm-44eae.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAWsUsIWCE9M77ZjoGwL7ijTm3lkt84ss4',
    appId: '1:975595926123:ios:20234c11d8ffe2fe0b372e',
    messagingSenderId: '975595926123',
    projectId: 'calm-44eae',
    storageBucket: 'calm-44eae.appspot.com',
    iosBundleId: 'com.example.calm',
  );

}