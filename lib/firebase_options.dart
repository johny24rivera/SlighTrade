// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDjMpLcJVwMQTpwO9jzlC8JpfItbrmis04',
    appId: '1:806590349820:web:a3863ac490db508056f279',
    messagingSenderId: '806590349820',
    projectId: 'slightrade',
    authDomain: 'slightrade.firebaseapp.com',
    storageBucket: 'slightrade.appspot.com',
    measurementId: 'G-8CS7J25RCC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDOWCrpP5BjhTPTaNxhZKFFhJDRYB4nDB4',
    appId: '1:806590349820:android:a2fe6d6959dcff0856f279',
    messagingSenderId: '806590349820',
    projectId: 'slightrade',
    storageBucket: 'slightrade.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAZVEghmgJNQNQsjki8sOFZAk7lqDjUFR0',
    appId: '1:806590349820:ios:934b104a5e1ed59356f279',
    messagingSenderId: '806590349820',
    projectId: 'slightrade',
    storageBucket: 'slightrade.appspot.com',
    iosClientId: '806590349820-n5eq385d411nsch03cmkrjpujktcmo35.apps.googleusercontent.com',
    iosBundleId: 'com.slighteade.app',
  );
}
