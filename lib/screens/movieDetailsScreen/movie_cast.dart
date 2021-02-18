import 'package:flutter/material.dart';
import 'package:movitm/assets/api_url.dart';
import 'package:movitm/logic/model/movie_cast_model.dart';

class MovieCast extends StatelessWidget {
  final Cast movieCast;

  const MovieCast({Key key, @required this.movieCast}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String profileURL = movieCast.profilePath == null
        ? null : ApiURL.posterBaseURL + movieCast.profilePath;

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width * 0.2,
            decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(profileURL),
              ),
            ),
          ),
          Text(
            movieCast.name,
            style: TextStyle(
              fontSize: 17.0,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}