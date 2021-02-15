import 'dart:async';
import 'dart:convert';

import 'package:movitm/assets/api_url.dart';
import 'home_screen_movie_content.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import '../../movie_response.dart';
export 'home_screen_movie_content.dart';


Future<MovieResponse> getMovies(String url) async {
  var response = await http
      .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
  return MovieResponse.fromJson(json.decode(response.body));
}

class MovieBloc{
  MovieBloc._internal();

  static final _singleton = MovieBloc._internal();

  factory MovieBloc() => _singleton;

  HomeScreenMovieContent homeScreenMovieContent = HomeScreenMovieContent(
    popular: null,
    streamingNow: null,
    topRated: null,
    upcomingMovies: null,
  );

  var _movieResponseSubject = BehaviorSubject<HomeScreenMovieContent>();
  var _similarMovieSubject = BehaviorSubject<MovieResponse>();

  Stream<HomeScreenMovieContent> get movieStream => _movieResponseSubject.stream;

  init() {
    this.addUpcomingMovies();
    this.addStreamingMovies();
    this.addTopRatedMovies();
    this.addPopularMovies();
  }

  addUpcomingMovies() async {
    var _movies = await getMovies(ApiURL.upcomingMovieURL);
    homeScreenMovieContent.upcomingMovies = _movies;
    _movieResponseSubject.sink.add(homeScreenMovieContent);
  }

  addStreamingMovies() async {
    var _movies = await getMovies(ApiURL.streamingMovieURL);
    homeScreenMovieContent.streamingNow = _movies;
    _movieResponseSubject.sink.add(homeScreenMovieContent);
  }

  addTopRatedMovies() async {
    var _movies = await getMovies(ApiURL.topRatedMovieURL);
    homeScreenMovieContent.topRated = _movies;
    _movieResponseSubject.sink.add(homeScreenMovieContent);
  }

  addPopularMovies() async {
    var _movies = await getMovies(ApiURL.popularMovieURL);
    homeScreenMovieContent.popular = _movies;
    _movieResponseSubject.sink.add(homeScreenMovieContent);
  }

  dispose() {
    _movieResponseSubject.close();
    _similarMovieSubject.close();
  }

  getSimilarMovies(int movieID)async{
    var url = 'https://api.themoviedb.org/3/movie/$movieID/similar${ApiURL.apiKey}&language=en-US&page=1';
    var response = await getMovies(url);
    _similarMovieSubject.sink.add(response);
  }

  Stream<MovieResponse> get similarMovie => _similarMovieSubject.stream;
}

