import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart'; // For kDebugMode
import 'failure.dart';

class ServerFailure extends Failure {
  const ServerFailure(super.errorMsg);

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerFailure(
            'The connection to the server timed out. Please check your internet connection and try again.');
      case DioExceptionType.sendTimeout:
        return const ServerFailure(
            'The request took too long to send. Please try again later.');
      case DioExceptionType.receiveTimeout:
        return const ServerFailure(
            'The server took too long to respond. Please try again in a moment.');
      case DioExceptionType.badCertificate:
        return const ServerFailure(
            'The server provided an invalid certificate. Please contact support.');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioError.response!.statusCode!,
          dioError.response!.data,
        );
      case DioExceptionType.cancel:
        return const ServerFailure(
            'The request was canceled. If this was unintentional, please try again.');
      case DioExceptionType.connectionError:
        return const ServerFailure(
            'There was an issue with the connection. Please check your network and try again.');
      case DioExceptionType.unknown:
        if (dioError.error is SocketException) {
          return const ServerFailure(
              'It seems you are offline. Please check your internet connection and try again.');
        }
        return const ServerFailure(
            'An unexpected error occurred. Please try again or contact support if the issue persists.');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    // Log detailed error info for debugging in development mode
    if (kDebugMode) {
      debugPrint('Server error: statusCode=$statusCode, response=$response');
    }

    // Handle cases where response is not a map or lacks expected fields
    String errorMessage = 'An error occurred while processing your request. Please try again.';
    if (response is Map<String, dynamic>) {
      // Extract error message based on your API structure
      final responseCode = response['code'] as String?;
      switch (statusCode) {
        case 400:
          errorMessage = responseCode != null
              ? 'Bad request: $responseCode. Please check your input and try again.'
              : 'Bad request. Please check your input and try again.';
          break;
        case 401:
          errorMessage = responseCode == 'Unauthorized'
              ? 'You are not authorized. Please check your credentials and try again.'
              : 'Unauthorized access. Please log in and try again.';
          break;
        case 403:
          errorMessage = responseCode != null
              ? 'Access forbidden: $responseCode. Please contact support if this persists.'
              : 'Access forbidden. You don’t have permission to perform this action.';
          break;
        case 404:
          errorMessage =
              'The requested resource could not be found. Please check the URL or try again later.';
          break;
        case 429:
          errorMessage =
              'You have exceeded the rate limit. Please wait a few minutes and try again.';
          break;
        case 500:
          errorMessage =
              'The server encountered an internal error. Please try again later or contact support.';
          break;
        default:
          errorMessage = responseCode != null
              ? 'Error: $responseCode. Please try again or contact support.'
              : 'An unexpected server error occurred. Please try again or contact support.';
      }
    }

    return ServerFailure(errorMessage);
  }
}