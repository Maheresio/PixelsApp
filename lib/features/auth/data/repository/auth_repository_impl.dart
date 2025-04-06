import 'dart:io';

import 'package:pixels_app/core/error/failure.dart';
import 'package:pixels_app/core/error/firebase_failure.dart';
import 'package:pixels_app/core/error/socket_failure.dart';

import '../services/auth_service.dart';
import 'auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _service;

  AuthRepositoryImpl(this._service);

  @override
  Stream<User?> get authStateChanges => _service.authStateChanges;

  @override
  Future<User?> signInWithEmail(String email, String password) async {
    return _handleExceptions(() => _service.signInWithEmail(email, password));
  }

  @override
  Future<User?> registerWithEmail(String email, String password) async {
    return _handleExceptions(() => _service.registerWithEmail(email, password));
  }

  @override
  Future<User?> signInWithGoogle() async {
    return _handleExceptions(() => _service.signInWithGoogle());
  }

  @override
  Future<void> signOut() async {
    await _handleExceptions(() => _service.signOut());
  }

  Future<T> _handleExceptions<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on FirebaseAuthException catch (e) {
      throw FirebaseFailure.fromCode(e.code);
    } on SocketException catch (e) {
      throw SocketFailure.fromCode(e.message);
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
