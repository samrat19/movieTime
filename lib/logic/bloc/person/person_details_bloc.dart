import 'dart:async';
import 'dart:convert';
import 'package:movitm/assets/api_url.dart';
import 'package:movitm/logic/model/person/person_image_model.dart';
import 'package:movitm/logic/model/person/person_link_model.dart';
import 'package:movitm/logic/model/person/person_movie_model.dart';
import 'package:movitm/logic/model/person_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

import 'person_details_manager.dart';
export 'person_details_manager.dart';

Future<PersonModel> getPersonDetails(String url) async {
  var response = await http
      .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
  return PersonModel.fromJson(json.decode(response.body));
}

Future<PersonMovieModel> getPersonMovie(String url) async {
  var response = await http
      .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
  return PersonMovieModel.fromJson(json.decode(response.body));
}

Future<PersonLinkModel> getPersonLink(String url) async {
  var response = await http
      .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
  return PersonLinkModel.fromJson(json.decode(response.body));
}

Future<PersonImageModel> getPersonImages(String url) async {
  var response = await http
      .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
  return PersonImageModel.fromJson(json.decode(response.body));
}

class PersonDetailsBloc{
  PersonDetailsBloc._internal();

  static final _singleton = PersonDetailsBloc._internal();

  factory PersonDetailsBloc() => _singleton;

  PersonDetailsManager personManager = PersonDetailsManager(
   images: null,
    links: null,
    movies: null,
    person: null,
  );

  var _personDetailsSubject = BehaviorSubject<PersonDetailsManager>();
  var _personSubject = BehaviorSubject<PersonModel>();

  Stream<PersonDetailsManager> get personDetailsStream => _personDetailsSubject.stream;
  Stream<PersonModel> get personStream => _personSubject.stream;

  init(int personID) {
    this.addMovieDetails(personID);
    this.addPersonLink(personID);
    this.addPersonImages(personID);
  }

  addMovieDetails(int personID) async {
    var _movies = await getPersonMovie('https://api.themoviedb.org/3/person/$personID/movie_credits${ApiURL.apiKey}&language=en-US');
    personManager.movies = _movies;
    _personDetailsSubject.sink.add(personManager);
  }

  addPersonLink(int personID) async {
    var _links = await getPersonLink('https://api.themoviedb.org/3/person/$personID/external_ids${ApiURL.apiKey}&language=en-US');
    personManager.links = _links;
    _personDetailsSubject.sink.add(personManager);
  }

  addPersonImages(int personID) async {
    var _images = await getPersonImages('https://api.themoviedb.org/3/person/$personID/images${ApiURL.apiKey}');
    personManager.images = _images;
    _personDetailsSubject.sink.add(personManager);
  }


  getPerson(int personID) async {
    var _person = await getPersonDetails('https://api.themoviedb.org/3/person/$personID${ApiURL.apiKey}&language=en-US');
    personManager.person  = _person;
    _personDetailsSubject.sink.add(personManager);
  }

  dispose() {
    _personDetailsSubject.close();
    _personSubject.close();
  }
}

