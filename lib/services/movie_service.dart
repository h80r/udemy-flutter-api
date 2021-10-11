// Packages
import 'package:get_it/get_it.dart';

// Services
import 'package:flickd_app/services/http_service.dart';

// Models
import 'package:flickd_app/models/movie.dart';

class MovieService {
  final _getIt = GetIt.instance;
  late final HttpService _http;

  MovieService() {
    _http = _getIt.get<HttpService>();
  }

  Future<List<Movie>> getMovieByCategory({
    required int page,
    required String category,
  }) async {
    final response = await _http.get(
      '/movie/$category',
      userQuery: {'page': page},
    );

    if (response?.statusCode == 200) {
      final data = response?.data;
      final movies = data?['results']
          .map<Movie>((e) => Movie.fromJson(e))
          .toList() as List<Movie>;

      return movies;
    }

    throw Exception("Couldn't load $category movies");
  }
}
