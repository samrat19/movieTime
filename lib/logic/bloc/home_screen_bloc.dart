import 'dart:async';
import 'dart:convert';

import 'package:movitm/assets/api_url.dart';
import 'package:movitm/logic/model/home_screen_movie_content.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import '../movie_response.dart';
export 'package:movitm/logic/model/home_screen_movie_content.dart';


Future<MovieResponse> getMovies(String url) async {
  var response = await http
      .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
  return MovieResponse.fromJson(json.decode(response.body));
}

class HomeScreenBloc{
  HomeScreenBloc._internal();

  static final _singleton = HomeScreenBloc._internal();

  factory HomeScreenBloc() => _singleton;

  HomeScreenMovieContent homeScreenMovieContent = HomeScreenMovieContent(
    popular: [],
    streamingNow: [],
    topRated: [],
    upcomingMovies: [],
  );

  var _movieResponseSubject = BehaviorSubject<HomeScreenMovieContent>();

  Stream<HomeScreenMovieContent> get movieStream => _movieResponseSubject.stream;

  init() {
    this.addUpcomingMovies();
    this.addStreamingMovies();
    this.addTopRatedMovies();
    this.addPopularMovies();
  }

  addUpcomingMovies() async {
    var _movies = await getMovies(ApiURL.upcomingMovieURL);
    homeScreenMovieContent.upcomingMovies = _movies.movieList;
    _movieResponseSubject.sink.add(homeScreenMovieContent);
  }

  addStreamingMovies() async {
    var _movies = await getMovies(ApiURL.streamingMovieURL);
    homeScreenMovieContent.streamingNow = _movies.movieList;
    _movieResponseSubject.sink.add(homeScreenMovieContent);
  }

  addTopRatedMovies() async {
    var _movies = await getMovies(ApiURL.topRatedMovieURL);
    homeScreenMovieContent.topRated = _movies.movieList;
    _movieResponseSubject.sink.add(homeScreenMovieContent);
  }

  addPopularMovies() async {
    var _movies = await getMovies(ApiURL.popularMovieURL);
    homeScreenMovieContent.popular = _movies.movieList;
    _movieResponseSubject.sink.add(homeScreenMovieContent);
  }

  dispose() {
    _movieResponseSubject.close();
  }
}

