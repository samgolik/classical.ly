// Generated from the Firebase configurations registered for classical-ly.
import 'dart:io' show Platform;

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show kIsWeb;

abstract final class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) throw UnsupportedError('Firebase web is not configured yet.');
    if (Platform.isIOS) return ios;
    if (Platform.isAndroid) return android;
    throw UnsupportedError('Firebase is not configured for this platform.');
  }

  static const ios = FirebaseOptions(
    apiKey: 'AIzaSyCg_b9v9AvaQtjqoqNaZQ87NaWeUaDytA8',
    appId: '1:1067398640227:ios:e62387a502fce12cd6be56',
    messagingSenderId: '1067398640227',
    projectId: 'classical-ly',
    storageBucket: 'classical-ly.firebasestorage.app',
    iosBundleId: 'com.beattheclockstudios.classically',
  );

  static const android = FirebaseOptions(
    apiKey: 'AIzaSyBfh-HR_sCJfFAthzxAIKbv-ddfWSrNgf8',
    appId: '1:1067398640227:android:2070487ba827c4c0d6be56',
    messagingSenderId: '1067398640227',
    projectId: 'classical-ly',
    storageBucket: 'classical-ly.firebasestorage.app',
  );
}
