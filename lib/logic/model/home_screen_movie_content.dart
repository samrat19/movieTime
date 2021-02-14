import 'package:flutter/cupertino.dart';
import 'package:movitm/logic/model/movie_model.dart';
import 'package:movitm/logic/movie_response.dart';

class HomeScreenMovieContent {
  List<MovieModel> upcomingMovies, streamingNow, topRated, popular;

  HomeScreenMovieContent({
    @required this.upcomingMovies,
    @required this.streamingNow,
    @required this.topRated,
    @required this.popular,
  });
}
