import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider =
    Provider<MyFirebaseAuthService>((ref) => MyFirebaseAuthService());

class MyFirebaseAuthService {
  final _auth = FirebaseAuth.instance;

  User? get user => _auth.currentUser;

  Stream<User?> authStateChanges() => _auth.userChanges();

  Future<User?> signInAnonymously() async {
    final userCredential = await _auth.signInAnonymously();
    return userCredential.user;
  }

  Future<User?> signInEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<UserCredential> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
