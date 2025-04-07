import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class ApiConstants {
  static final String _apiKey = dotenv.env['PEXELS_API_KEY']!;
  static const String _baseUrl = 'https://api.pexels.com/v1/';

  static String curatedPhotos(int page) =>
      '${_baseUrl}curated?page=$page&per_page=40';

  static Map<String, String> get headers => {'Authorization': _apiKey};

  static String searchPhotos(
    String query,
    int page, {
    int perPage = 40,
    String? orientation,
    String? size,
    String? color,
  }) {
    final filters = [
      if (orientation != null) 'orientation=$orientation',
      if (size != null) 'size=$size',
      if (color != null) 'color=$color',
    ].join('&');
    return '$_baseUrl'
        'search?query=$query&page=$page&per_page=$perPage'
        '${filters.isNotEmpty ? '&$filters' : ''}';
  }
}
