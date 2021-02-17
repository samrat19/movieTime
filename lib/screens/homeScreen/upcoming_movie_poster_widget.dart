import 'package:flutter/material.dart';
import 'package:movitm/assets/api_url.dart';
import 'package:movitm/logic/model/movie_model.dart';

class UpcomingMoviePosterWidget extends StatelessWidget {
  final MovieModel movie;

  const UpcomingMoviePosterWidget({Key key, @required this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.8,
      decoration: BoxDecoration(
        color: Colors.transparent,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(ApiURL.posterBaseURL + movie.backdropPath),
        ),
      ),
    );
  }
}