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
    apiKey: 'AIzaSyDSNF9qz7lN-HvIIhawIzfGp6Xy3PBkeC8',
    appId: '1:878638150557:web:ca5c75fde7179cc9ee3574',
    messagingSenderId: '878638150557',
    projectId: 'teraflex-dc661',
    authDomain: 'teraflex-dc661.firebaseapp.com',
    storageBucket: 'teraflex-dc661.appspot.com',
    measurementId: 'G-MTHFMLHJCE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB3ZQ8HEFgWSVobgPlYMAsrWeuWhAExaGo',
    appId: '1:878638150557:android:8aed375e072ae61cee3574',
    messagingSenderId: '878638150557',
    projectId: 'teraflex-dc661',
    storageBucket: 'teraflex-dc661.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC3ugK9cKGV2MeVeAGCXqXlyEf6qwbHOD8',
    appId: '1:878638150557:ios:99d6bd8f53269caeee3574',
    messagingSenderId: '878638150557',
    projectId: 'teraflex-dc661',
    storageBucket: 'teraflex-dc661.appspot.com',
    iosClientId: '878638150557-9g0ird0k26q5400070d2hpe8ganeaiuv.apps.googleusercontent.com',
    iosBundleId: 'com.example.fisioflex',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC3ugK9cKGV2MeVeAGCXqXlyEf6qwbHOD8',
    appId: '1:878638150557:ios:51fa95c1238d81dcee3574',
    messagingSenderId: '878638150557',
    projectId: 'teraflex-dc661',
    storageBucket: 'teraflex-dc661.appspot.com',
    iosClientId: '878638150557-ff1re4do3mk4kpq0ifmktd0kmg0spq4o.apps.googleusercontent.com',
    iosBundleId: 'com.example.fisioflex.RunnerTests',
  );
}
