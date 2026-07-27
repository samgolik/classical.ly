import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  AuthService._();
  static final instance = AuthService._();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> get changes => auth.authStateChanges();
  Future<UserCredential> signInWithEmail(String email, String password) => auth.signInWithEmailAndPassword(email: email.trim(), password: password);
  Future<UserCredential> createWithEmail(String email, String password) => auth.createUserWithEmailAndPassword(email: email.trim(), password: password);

  Future<UserCredential> signInWithGoogle() async {
    final account = await GoogleSignIn().signIn();
    if (account == null) throw const AuthCancelledException();
    final tokens = await account.authentication;
    final credential = GoogleAuthProvider.credential(accessToken: tokens.accessToken, idToken: tokens.idToken);
    return auth.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithApple() async {
    final rawNonce = _nonce();
    final apple = await SignInWithApple.getAppleIDCredential(scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName], nonce: sha256.convert(utf8.encode(rawNonce)).toString());
    final credential = OAuthProvider('apple.com').credential(idToken: apple.identityToken, rawNonce: rawNonce, accessToken: apple.authorizationCode);
    return auth.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await auth.signOut();
  }

  String _nonce([int length = 32]) {
    const chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => chars[random.nextInt(chars.length)]).join();
  }
}

class AuthCancelledException implements Exception {
  const AuthCancelledException();
}
