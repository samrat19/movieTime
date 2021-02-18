import 'package:flutter/material.dart';
import 'package:movitm/logic/model/person/person_movie_model.dart';
import 'package:movitm/tools/movie_poster_widget.dart';

class MovieSegment extends StatelessWidget {
  final PersonMovieModel movies;

  const MovieSegment({Key key, @required this.movies}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.35,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: movies.movies.length,
        itemBuilder: (_, index) {
          print(movies.movies[index].posterPath);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: MoviePosterWidget(
              movie: movies.movies[index],
            ),
          );
        },
        separatorBuilder: (_, index) => SizedBox(width: 2.0),
      ),
    );
  }
}