// Packages
import 'package:flickd_app/models/search_category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

// Services
import 'package:flickd_app/services/movie_service.dart';

// Models
import 'package:flickd_app/models/main_page_data.dart';

class MainPageDataController extends StateNotifier<MainPageData> {
  MainPageDataController() : super(MainPageData.initial()) {
    getMovies();
  }

  final _movieService = GetIt.instance.get<MovieService>();

  Future<void> getMovies() async {
    try {
      final movies = await _movieService.getMovieByCategory(
        category: state.searchCategory.endPoint,
        page: state.page,
      );
      state = state.copyWith(
        movies: [...state.movies, ...movies],
        page: state.page + 1,
      );
    } catch (e) {
      print(e);
    }
  }

  void updateSearchCategory(SearchCategory? searchCategory) {
    try {
      state = state.copyWith(
        searchCategory: searchCategory,
        page: 1,
        movies: [],
        searchText: '',
      );
      getMovies();
    } catch (e) {
      print(e);
    }
  }
}
