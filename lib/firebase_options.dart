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
    apiKey: 'AIzaSyD0jxMLb8KpioJL-kCrFyoq-aV7e7TQCss',
    appId: '1:14438509782:web:0a15b5841b551e538dad77',
    messagingSenderId: '14438509782',
    projectId: 'tmanager-78c5a',
    authDomain: 'tmanager-78c5a.firebaseapp.com',
    storageBucket: 'tmanager-78c5a.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAfGD7p6vK8vpRRr4Qmhh3DkHV78ym5wb8',
    appId: '1:14438509782:android:971040f4de6bc6398dad77',
    messagingSenderId: '14438509782',
    projectId: 'tmanager-78c5a',
    storageBucket: 'tmanager-78c5a.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAk6QY_M2xTkMe7faTAWPTObFnNOWPScrM',
    appId: '1:14438509782:ios:715e9d9c6cf18b708dad77',
    messagingSenderId: '14438509782',
    projectId: 'tmanager-78c5a',
    storageBucket: 'tmanager-78c5a.firebasestorage.app',
    iosBundleId: 'com.tmanager.tmanager',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAk6QY_M2xTkMe7faTAWPTObFnNOWPScrM',
    appId: '1:14438509782:ios:715e9d9c6cf18b708dad77',
    messagingSenderId: '14438509782',
    projectId: 'tmanager-78c5a',
    storageBucket: 'tmanager-78c5a.firebasestorage.app',
    iosBundleId: 'com.tmanager.tmanager',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD0jxMLb8KpioJL-kCrFyoq-aV7e7TQCss',
    appId: '1:14438509782:web:5ad776f6135385cb8dad77',
    messagingSenderId: '14438509782',
    projectId: 'tmanager-78c5a',
    authDomain: 'tmanager-78c5a.firebaseapp.com',
    storageBucket: 'tmanager-78c5a.firebasestorage.app',
  );
}
