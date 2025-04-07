import 'package:dio/dio.dart';
import '../api_constants.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio) {
    _dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: ApiConstants.headers,
    );


  }

  Future<Map<String, dynamic>> get({required String url}) async {
    final response = await _dio.get(url);

    return response.data;
  }


Future<Map<String, dynamic>> searchPhotos({
  required String query,
  required int page,
  String? orientation,
  String? size,
  String? color,
}) async {
  final url = ApiConstants.searchPhotos(query, page,
      orientation: orientation, size: size, color: color);
  final response = await _dio.get(url);
  return response.data;
}


}
