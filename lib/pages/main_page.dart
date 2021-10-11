import 'dart:ui';

// Packages
import 'package:flickd_app/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Widgets
import 'package:flickd_app/widgets/movie_tile.dart';

// Models
import 'package:flickd_app/models/search_category.dart';

// ignore: must_be_immutable
class MainPage extends ConsumerWidget {
  MainPage({Key? key}) : super(key: key);

  var _deviceHeight = 0.0;
  var _deviceWidth = 0.0;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
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
        image: const DecorationImage(
          image: NetworkImage(
            'https://images-na.ssl-images-amazon.com/images/I/91B32iU7ayL._AC_SL1500_.jpg',
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
        mainAxisAlignment: MainAxisAlignment.start,
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
      child: TextFormField(
        onFieldSubmitted: (_) => {},
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
      value: SearchCategory.popular,
      icon: const Icon(
        Icons.menu,
        color: Colors.white24,
      ),
      underline: Container(
        height: 1.0,
        color: Colors.white24,
      ),
      onChanged: (_) => {},
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
    final movies = List.filled(
      20,
      Movie(
        name: 'Mortal Kombat',
        language: 'EN',
        isAdult: false,
        description:
            '''Mortal Kombat is a 2021 martial arts fantasy film based on the 
          video game franchise of the same name and a reboot of the Mortal 
          Kombat film series. ... The film follows Cole Young, a washed-up 
          mixed martial arts fighter who is unaware of his hidden lineage or 
          why assassin Sub-Zero is hunting him down.''',
        posterPath: '/ijvC2w2yANsfgLT3LMu2zFr0fxh.jpg',
        backdropPath: '/9yBVqNruk6Ykrwc32qrK2TIE5xw.jpg',
        rating: 7.8,
        releaseDate: '2021-04-07',
      ),
    );

    return movies.isEmpty
        ? const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
          )
        : ListView.builder(
            itemCount: movies.length,
            itemBuilder: (_, i) => Padding(
              padding: EdgeInsets.symmetric(
                vertical: _deviceHeight * 0.01,
              ),
              child: GestureDetector(
                onTap: () => {},
                child: MovieTile(
                  height: _deviceHeight * 0.2,
                  width: _deviceWidth * 0.85,
                  movie: movies[i],
                ),
              ),
            ),
          );
  }
}
