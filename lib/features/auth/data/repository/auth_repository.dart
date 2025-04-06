
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Stream<User?> get authStateChanges;

  Future<User?> signInWithEmail(String email, String password);
  Future<User?> registerWithEmail(String email, String password);
  Future<User?> signInWithGoogle();
  Future<void> signOut();
}
