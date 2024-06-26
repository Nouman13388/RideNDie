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
    apiKey: 'AIzaSyD-u91W-I99xU3UZPFIOAEqcxlU2xLLJ38',
    appId: '1:663396150618:web:3287b12df5ee97c5191763',
    messagingSenderId: '663396150618',
    projectId: 'ride-n-die-423406',
    authDomain: 'ride-n-die-423406.firebaseapp.com',
    storageBucket: 'ride-n-die-423406.appspot.com',
    measurementId: 'G-JVF31DQC49',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC-TTsu08XxQQL5IB60_HTQ_s-gRWnYbTA',
    appId: '1:663396150618:android:d0d769e59618e854191763',
    messagingSenderId: '663396150618',
    projectId: 'ride-n-die-423406',
    storageBucket: 'ride-n-die-423406.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBcZrS0Remd8xZWhqDsACXTuA8RmtmD2RY',
    appId: '1:663396150618:ios:455c2ebf7e809504191763',
    messagingSenderId: '663396150618',
    projectId: 'ride-n-die-423406',
    storageBucket: 'ride-n-die-423406.appspot.com',
    iosBundleId: 'com.example.frontend',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBcZrS0Remd8xZWhqDsACXTuA8RmtmD2RY',
    appId: '1:663396150618:ios:455c2ebf7e809504191763',
    messagingSenderId: '663396150618',
    projectId: 'ride-n-die-423406',
    storageBucket: 'ride-n-die-423406.appspot.com',
    iosBundleId: 'com.example.frontend',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD-u91W-I99xU3UZPFIOAEqcxlU2xLLJ38',
    appId: '1:663396150618:web:cc04941c7ddb7db8191763',
    messagingSenderId: '663396150618',
    projectId: 'ride-n-die-423406',
    authDomain: 'ride-n-die-423406.firebaseapp.com',
    storageBucket: 'ride-n-die-423406.appspot.com',
    measurementId: 'G-VYF6W9F57L',
  );
}
