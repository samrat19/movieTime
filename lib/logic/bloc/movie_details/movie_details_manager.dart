import 'package:flutter/cupertino.dart';
import 'package:movitm/logic/model/movie_cast_model.dart';
import 'package:movitm/logic/model/movie_details_model.dart';
import 'package:movitm/logic/movie_response.dart';

class MovieDetailsManager {
  MovieDetailsModel movieDetails;
  MovieCastModel movieCast;
  MovieResponse similarMovie;

  MovieDetailsManager({
    @required this.movieDetails,
    @required this.movieCast,
    @required this.similarMovie,
  });
}
