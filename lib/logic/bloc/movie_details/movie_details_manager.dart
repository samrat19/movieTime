import 'package:flutter/cupertino.dart';
import 'package:movitm/logic/model/movie_cast_model.dart';
import 'package:movitm/logic/model/movie_details_model.dart';

class MovieDetailsManager {
  MovieDetailsModel movieDetails;
  MovieCastModel movieCast;

  MovieDetailsManager({
    @required this.movieDetails,
    @required this.movieCast,
  });
}
