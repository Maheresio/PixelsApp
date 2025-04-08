import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/service_locator.dart';
import '../../data/repository/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return sl<AuthRepository>();
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
});

class AuthStateNotifier extends StateNotifier<AsyncValue<User?>> {
  final AuthRepository repository;
  AuthStateNotifier(this.repository) : super(const AsyncValue.data(null));

  Future<void> signInWithEmail(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      ()  => repository.signInWithEmail(email, password),
    );
  }

  Future<void> registerWithEmail(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      ()  => repository.registerWithEmail(email, password),
    );
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(()  => repository.signInWithGoogle());
  }

  Future<void> signOut() async {
  state = const AsyncValue.loading();
  await AsyncValue.guard(() => repository.signOut());
  state = const AsyncValue.data(null);
}
}
final authProvider =
    StateNotifierProvider<AuthStateNotifier, AsyncValue<User?>>((ref) {
      return AuthStateNotifier(ref.watch(authRepositoryProvider));
    });


final loginProvider = StateNotifierProvider.autoDispose<AuthStateNotifier, AsyncValue<User?>>((ref) {
  return AuthStateNotifier(ref.watch(authRepositoryProvider));
});

final registerProvider = StateNotifierProvider.autoDispose<AuthStateNotifier, AsyncValue<User?>>((ref) {
  return AuthStateNotifier(ref.watch(authRepositoryProvider));
});