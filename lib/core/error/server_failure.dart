import 'package:dio/dio.dart';
import 'failure.dart';

class ServerFailure extends Failure {
  const ServerFailure(super.errorMsg);

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerFailure('Connection timeout with ApiServer');
      case DioExceptionType.sendTimeout:
        return const ServerFailure('Send timeout with ApiServer');

      case DioExceptionType.receiveTimeout:
        return const ServerFailure('Receive timeout with ApiServer');

      case DioExceptionType.badCertificate:
        return const ServerFailure('Bad Certificate with ApiServer');

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioError.response!.statusCode!,
          dioError.response!.data,
        );

      case DioExceptionType.cancel:
        return const ServerFailure('Request to Api was canceled');

      case DioExceptionType.connectionError:
        return const ServerFailure('Something wrong with the connections');

      case DioExceptionType.unknown:
        if (dioError.message!.contains('SocketException')) {
          return const ServerFailure('No Internet Connection');
        }
        return const ServerFailure('Unexpected Error, Please try again!');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['error']['message']);
    } else if (statusCode == 404) {
      return const ServerFailure('Your request not found, Please try later!');
    } else if (statusCode == 500) {
      return const ServerFailure('Internal Server error, Please try later');
    } else {
      return const ServerFailure('Opps There was an Error, Please try again');
    }
  }
}
