import 'package:flutter/cupertino.dart';
import 'package:movitm/logic/movie_response.dart';

class HomeScreenMovieContent {
  MovieResponse upcomingMovies, streamingNow, topRated, popular;

  HomeScreenMovieContent({
    @required this.upcomingMovies,
    @required this.streamingNow,
    @required this.topRated,
    @required this.popular,
  });
}
