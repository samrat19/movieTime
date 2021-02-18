import 'package:flutter/material.dart';
import 'package:movitm/logic/bloc/person/person_details_bloc.dart';
import 'package:movitm/tools/movie_poster_widget.dart';

class MovieSegment extends StatelessWidget {
  final AsyncSnapshot<PersonDetailsManager> snapShot;

  const MovieSegment({Key key, @required this.snapShot}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.35,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: snapShot.data.movies.movies.length,
        itemBuilder: (_, index) {
          print(snapShot.data.movies.movies[index].posterPath);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: MoviePosterWidget(
              movie: snapShot.data.movies.movies[index],
            ),
          );
        },
        separatorBuilder: (_, index) => SizedBox(width: 2.0),
      ),
    );
  }
}