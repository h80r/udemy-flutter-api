import 'dart:ui';

// Packages
import 'package:flickd_app/models/main_page_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Widgets
import 'package:flickd_app/widgets/movie_tile.dart';

// Models
import 'package:flickd_app/models/search_category.dart';

// Controllers
import 'package:flickd_app/controllers/main_page_data_controller.dart';

final mainPageDataControllerProvider =
    StateNotifierProvider<MainPageDataController, MainPageData>(
  (ref) => MainPageDataController(),
);

final selectedMoviePosterProvider = StateProvider<String?>((ref) {
  final movies = ref.watch(mainPageDataControllerProvider).movies;
  return movies.isNotEmpty ? movies.first.posterUrl : null;
});

// ignore: must_be_immutable
class MainPage extends ConsumerWidget {
  MainPage({Key? key}) : super(key: key);

  var _deviceHeight = 0.0;
  var _deviceWidth = 0.0;

  late MainPageDataController _mainPageDataController;
  late MainPageData _mainPageData;

  late TextEditingController _searchTextFieldController;

  late StateController<String?> _selectedMoviePoster;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    _mainPageDataController =
        context.read(mainPageDataControllerProvider.notifier);
    _mainPageData = watch(mainPageDataControllerProvider);

    _searchTextFieldController = TextEditingController();
    _searchTextFieldController.text = _mainPageData.searchText;

    _selectedMoviePoster = watch(selectedMoviePosterProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            _backgroundWidget(),
            _foregroundWidgets(),
          ],
        ),
      ),
    );
  }

  Widget _backgroundWidget() {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: NetworkImage(
            _selectedMoviePoster.state ?? '',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
          ),
        ),
      ),
    );
  }

  Widget _foregroundWidgets() {
    return Container(
      padding: EdgeInsets.only(top: _deviceHeight * 0.02),
      width: _deviceWidth * 0.88,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _topBarWidget(),
          Container(
            height: _deviceHeight * 0.83,
            padding: EdgeInsets.symmetric(
              vertical: _deviceHeight * 0.01,
            ),
            child: _moviesListViewWidget(),
          ),
        ],
      ),
    );
  }

  Widget _topBarWidget() {
    return Container(
      height: _deviceHeight * 0.08,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _searchFieldWidget(),
          _categorySelectionWidget(),
        ],
      ),
    );
  }

  Widget _searchFieldWidget() {
    return SizedBox(
      width: _deviceWidth * 0.5,
      height: _deviceHeight * 0.05,
      child: TextField(
        controller: _searchTextFieldController,
        onSubmitted: _mainPageDataController.updateTextSearch,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.white24,
          ),
          hintStyle: TextStyle(color: Colors.white54),
          hintText: 'Search....',
        ),
      ),
    );
  }

  Widget _categorySelectionWidget() {
    return DropdownButton(
      dropdownColor: Colors.black38,
      value: _mainPageData.searchCategory,
      icon: const Icon(
        Icons.menu,
        color: Colors.white24,
      ),
      underline: Container(
        height: 1.0,
        color: Colors.white24,
      ),
      onChanged: _mainPageDataController.updateSearchCategory,
      items: SearchCategory.values
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e.label,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _moviesListViewWidget() {
    final movies = _mainPageData.movies;

    return movies.isEmpty
        ? const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
          )
        : NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is! ScrollEndNotification) return false;
              final before = notification.metrics.extentBefore;
              final max = notification.metrics.maxScrollExtent;
              if (before != max) return false;
              _mainPageDataController.getMovies();
              return true;
            },
            child: ListView.builder(
              itemCount: movies.length,
              itemBuilder: (_, i) => Padding(
                padding: EdgeInsets.symmetric(
                  vertical: _deviceHeight * 0.01,
                ),
                child: GestureDetector(
                  onTap: () {
                    _selectedMoviePoster.state = movies[i].posterUrl;
                  },
                  child: MovieTile(
                    height: _deviceHeight * 0.2,
                    width: _deviceWidth * 0.85,
                    movie: movies[i],
                  ),
                ),
              ),
            ),
          );
  }
}
