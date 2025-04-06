import 'failure.dart';

class FirebaseFailure extends Failure {
  const FirebaseFailure(super.message);

  factory FirebaseFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return FirebaseFailure('The email address is not valid.');
      case 'user-disabled':
        return FirebaseFailure(
          'The user corresponding to the given email has been disabled.',
        );
      case 'user-not-found':
        return FirebaseFailure(
          'No user found corresponding to the given email.',
        );
      case 'wrong-password':
        return FirebaseFailure('The password is invalid for the given email.');
      case 'too-many-requests':
        return FirebaseFailure('Too many requests. Please try again later.');
      case 'user-token-expired':
        return FirebaseFailure(
          'The user is no longer authenticated. Token has expired.',
        );
      case 'network-request-failed':
        return FirebaseFailure(
          'A network error occurred. Please check your connection.',
        );
      case 'invalid-credential':
      case 'INVALID_LOGIN_CREDENTIALS':
        return FirebaseFailure('Invalid login credentials provided.');
      case 'operation-not-allowed':
        return FirebaseFailure(
          'Email/password accounts are not enabled. Please contact support.',
        );
      default:
        return FirebaseFailure('An unknown error occurred.');
    }
  }
}
