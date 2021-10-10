// ignore_for_file: avoid_print

// Packages
import 'package:dio/dio.dart';
import 'package:flickd_app/models/app_config.dart';
import 'package:get_it/get_it.dart';

// Models

class HttpService {
  final dio = Dio();
  final getIt = GetIt.instance;

  late String _baseUrl;
  late String _apiKey;

  HttpService() {
    final config = getIt.get<AppConfig>();
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

      return await dio.get(url, queryParameters: query);
    } on DioError catch (e) {
      print('Unable to perform get request');
      print('DioError: $e');
    }
  }
}
