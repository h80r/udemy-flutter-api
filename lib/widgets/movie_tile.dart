// Packages
import 'package:flutter/material.dart';

// Models
import 'package:flickd_app/models/movie.dart';
import 'package:get_it/get_it.dart';

class MovieTile extends StatelessWidget {
  MovieTile({
    Key? key,
    required this.height,
    required this.width,
    required this.movie,
  }) : super(key: key);

  final double height;
  final double width;
  final Movie movie;

  final _getIt = GetIt.instance;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _moviePosterWidget(movie.posterUrl),
        _movieInfoWidget(),
      ],
    );
  }

  Widget _moviePosterWidget(String imageUrl) {
    return Container(
      height: height,
      width: width * 0.35,
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(imageUrl)),
      ),
    );
  }

  Widget _movieInfoWidget() {
    return SizedBox(
      height: height,
      width: width * 0.66,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: width * 0.56,
                child: Text(
                  movie.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Text(
                movie.rating.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: height * 0.02),
            child: Text(
              movie.language.toUpperCase() +
                  ' | R: ${movie.isAdult}' +
                  ' | ${movie.releaseDate}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: height * 0.07),
            child: Text(
              movie.description,
              maxLines: 9,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
