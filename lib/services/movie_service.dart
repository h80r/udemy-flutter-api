// Packages
import 'package:get_it/get_it.dart';

// Services
import 'package:flickd_app/services/http_service.dart';

class MovieService {
  final _getIt = GetIt.instance;
  late final HttpService _http;

  MovieService() {
    _http = _getIt.get<HttpService>();
  }
}
