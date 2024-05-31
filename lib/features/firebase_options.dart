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
    apiKey: 'AIzaSyAd73k-pS7rdSQb7690kbVtbsD0bE0jx1Y',
    appId: '1:704835850522:web:01d4849b7017decce19ca3',
    messagingSenderId: '704835850522',
    projectId: 'ulearning-app-93a0e',
    authDomain: 'ulearning-app-93a0e.firebaseapp.com',
    storageBucket: 'ulearning-app-93a0e.appspot.com',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBvMNxDSTFDjrnj0Xf80VCHEtgRsJPDsLI',
    appId: '1:704835850522:ios:894f60c7f475d5fde19ca3',
    messagingSenderId: '704835850522',
    projectId: 'ulearning-app-93a0e',
    storageBucket: 'ulearning-app-93a0e.appspot.com',
    iosBundleId: 'com.example.ulearningApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAd73k-pS7rdSQb7690kbVtbsD0bE0jx1Y',
    appId: '1:704835850522:web:11a5831cdbdcb63ae19ca3',
    messagingSenderId: '704835850522',
    projectId: 'ulearning-app-93a0e',
    authDomain: 'ulearning-app-93a0e.firebaseapp.com',
    storageBucket: 'ulearning-app-93a0e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBvMNxDSTFDjrnj0Xf80VCHEtgRsJPDsLI',
    appId: '1:704835850522:ios:671b43564157d353e19ca3',
    messagingSenderId: '704835850522',
    projectId: 'ulearning-app-93a0e',
    storageBucket: 'ulearning-app-93a0e.appspot.com',
    iosBundleId: 'com.KyleJhong.ulearningApp',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDHCW5oJpIsPfme_wjMOozVA-KSOwxbvP8',
    appId: '1:704835850522:android:9a769d2cb29f5de4e19ca3',
    messagingSenderId: '704835850522',
    projectId: 'ulearning-app-93a0e',
    storageBucket: 'ulearning-app-93a0e.appspot.com',
  );

}