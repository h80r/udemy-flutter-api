// ignore_for_file: avoid_print

// Packages
import 'package:dio/dio.dart';
import 'package:flickd_app/models/app_config.dart';
import 'package:get_it/get_it.dart';

// Models

class HttpService {
  final _dio = Dio();
  final _getIt = GetIt.instance;

  late final String _baseUrl;
  late final String _apiKey;

  HttpService() {
    final config = _getIt.get<AppConfig>();
    _baseUrl = config.baseApiUrl;
    _apiKey = config.apiKey;
  }

  Future<Response?> get(String path, {Map<String, dynamic>? userQuery}) async {
    try {
      final url = _baseUrl + path;
      final query = <String, dynamic>{
        'api_key': _apiKey,
        'language': 'en-US',
      };

      query.addAll(userQuery ?? {});

      return await _dio.get(url, queryParameters: query);
    } on DioError catch (e) {
      print('Unable to perform get request');
      print('DioError: $e');
    }
  }
}
