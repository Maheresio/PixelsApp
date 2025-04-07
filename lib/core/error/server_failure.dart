import 'package:dio/dio.dart';

import 'failure.dart';

class ServerFailure extends Failure {
  const ServerFailure(super.errorMsg);

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerFailure('The connection to the server timed out. Please check your internet connection and try again.');
      case DioExceptionType.sendTimeout:
        return const ServerFailure('The request took too long to send. Please try again later.');

      case DioExceptionType.receiveTimeout:
        return const ServerFailure('The server took too long to respond. Please try again in a moment.');

      case DioExceptionType.badCertificate:
        return const ServerFailure('The server provided an invalid certificate. Please contact support.');

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioError.response!.statusCode!,
          dioError.response!.data,
        );

      case DioExceptionType.cancel:
        return const ServerFailure('The request was canceled. If this was unintentional, please try again.');

      case DioExceptionType.connectionError:
        return const ServerFailure('There was an issue with the connection. Please check your network and try again.');

      case DioExceptionType.unknown:
        if (dioError.message!.contains('SocketException')) {
          return const ServerFailure('It seems you are offline. Please check your internet connection and try again.');
        }
        return const ServerFailure('An unexpected error occurred. Please try again or contact support if the issue persists.');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['error']['message']);
    } else if (statusCode == 404) {
      return const ServerFailure('The requested resource could not be found. Please check the URL or try again later.');
    } else if (statusCode == 500) {
      return const ServerFailure('The server encountered an internal error. Please try again later or contact support.');
    } else {
      return const ServerFailure('An error occurred while processing your request. Please try again or contact support.');
    }
  }
}
