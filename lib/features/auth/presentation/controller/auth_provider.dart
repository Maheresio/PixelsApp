import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/services/auth_service.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/auth_repository_impl.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(AuthService());
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
});

class AuthStateNotifier extends StateNotifier<AsyncValue<User?>> {
  final AuthRepository repository;
  AuthStateNotifier(this.repository) : super(const AsyncValue.data(null));

  Future<void> signInWithEmail(String email, String password) async {
    state = const AsyncValue.loading();
    final result = await AsyncValue.guard(
      () async => await repository.signInWithEmail(email, password),
    );
    state = result;
  }

  Future<void> registerWithEmail(String email, String password) async {
    state = const AsyncValue.loading();
    final result = await AsyncValue.guard(
      () async => await repository.registerWithEmail(email, password),
    );
    state = result;
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();
    final result = await AsyncValue.guard(
      () async => await repository.signInWithGoogle(),
    );
    state = result;
  }

  Future<void> signOut() async {
    await AsyncValue.guard(() async => await repository.signOut());
    state = const AsyncValue.data(null);
  }
}

final authProvider =
    StateNotifierProvider<AuthStateNotifier, AsyncValue<User?>>((ref) {
      return AuthStateNotifier(ref.watch(authRepositoryProvider));
    });
