import 'package:flutter/material.dart';
import 'package:movitm/logic/model/movie_model.dart';
import 'package:movitm/tools/movie_poster_widget.dart';

class MovieSectionWidget extends StatelessWidget {

  final List<MovieModel> movies;

  const MovieSectionWidget({Key key, @required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.3,
      foregroundDecoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            Colors.grey.withOpacity(0.2),
            Colors.white,
          ],
          begin: Alignment(0, -1),
          end: Alignment(0, 1),
        ),
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (_, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: MoviePosterWidget(
            movie: movies[index],
          ),
        ),
        separatorBuilder: (_, index) => SizedBox(
          width: 2.0,
        ),
      ),
    );
  }
}