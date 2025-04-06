import 'failure.dart';

class SocketFailure extends Failure {
  const SocketFailure(super.message);

  factory SocketFailure.fromCode(String code) {
    switch (code) {
      case 'network-request-failed':
        return SocketFailure(
          'A network error occurred. Please check your connection.',
        );
      default:
        return SocketFailure('An unknown error occurred.');
    }
  }
}
