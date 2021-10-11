// Packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

// Services
import 'package:flickd_app/services/movie_service.dart';

// Models
import 'package:flickd_app/models/main_page_data.dart';

class MainPageDataController extends StateNotifier<MainPageData> {
  MainPageDataController(MainPageData? state)
      : super(state ?? MainPageData.initial()) {
    getMovies();
  }

  final _movieService = GetIt.instance.get<MovieService>();

  Future<void> getMovies() async {
    try {
      var _movies = await _movieService.getPopularMovies(page: state.page);
    } catch (e) {}
  }
}
