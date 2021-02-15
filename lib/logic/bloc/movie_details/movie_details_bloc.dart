import 'dart:async';
import 'dart:convert';
import 'package:movitm/assets/api_url.dart';
import 'package:movitm/logic/model/movie_cast_model.dart';
import 'package:movitm/logic/model/movie_details_model.dart';
import 'package:movitm/logic/model/person_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

import 'movie_details_manager.dart';
export 'movie_details_manager.dart';


Future<MovieDetailsModel> getMovieDetails(String url) async {
  var response = await http
      .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
  return MovieDetailsModel.fromJson(json.decode(response.body));
}

Future<MovieCastModel> getMovieCast(String url) async {
  var response = await http
      .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
  return MovieCastModel.fromJson(json.decode(response.body));
}

Future<PersonModel> getPersonDetails(String url) async {
  var response = await http
      .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
  return PersonModel.fromJson(json.decode(response.body));
}

class MovieDetailsBloc{
  MovieDetailsBloc._internal();

  static final _singleton = MovieDetailsBloc._internal();

  factory MovieDetailsBloc() => _singleton;

  MovieDetailsManager movieManager = MovieDetailsManager(
    movieCast: null,
    movieDetails: null,
  );

  var _movieDetailsSubject = BehaviorSubject<MovieDetailsManager>();
  var _personSubject = BehaviorSubject<PersonModel>();

  Stream<MovieDetailsManager> get movieDetailsStream => _movieDetailsSubject.stream;
  Stream<PersonModel> get personStream => _personSubject.stream;

  init(int movieID) {
    this.addMovieDetails(movieID);
    this.addMovieCast(movieID);
  }

  addMovieDetails(int movieID) async {
    var _movieDetails = await getMovieDetails('${ApiURL.baseURL}$movieID${ApiURL.apiKey}&language=en-US');
    movieManager.movieDetails = _movieDetails;
    _movieDetailsSubject.sink.add(movieManager);
  }

  addMovieCast(int movieID) async {
    var _movieCast = await getMovieCast('${ApiURL.baseURL}$movieID/credits${ApiURL.apiKey}&language=en-US');
    movieManager.movieCast = _movieCast;
    _movieDetailsSubject.sink.add(movieManager);
  }

  getPerson(int personID) async {
    var _person = await getPersonDetails('https://api.themoviedb.org/3/person/$personID${ApiURL.apiKey}&language=en-US');
    _personSubject.sink.add(_person);
  }


  dispose() {
    _movieDetailsSubject.close();
    _personSubject.close();
  }
}

