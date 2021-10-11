// Models
import 'package:flickd_app/models/movie.dart';
import 'package:flickd_app/models/search_category.dart';

class MainPageData {
  final List<Movie> movies;
  final int page;
  final SearchCategory searchCategory;
  final String searchText;

  MainPageData({
    required this.movies,
    required this.page,
    required this.searchCategory,
    required this.searchText,
  });

  MainPageData.initial()
      : movies = <Movie>[],
        page = 1,
        searchCategory = SearchCategory.popular,
        searchText = '';

  MainPageData copyWith({
    List<Movie>? movies,
    int? page,
    SearchCategory? searchCategory,
    String? searchText,
  }) {
    return MainPageData(
      movies: movies ?? this.movies,
      page: page ?? this.page,
      searchCategory: searchCategory ?? this.searchCategory,
      searchText: searchText ?? this.searchText,
    );
  }
}
