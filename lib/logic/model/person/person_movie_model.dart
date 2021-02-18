import 'package:movitm/logic/model/movie_model.dart';

class PersonMovieModel {
  List<MovieModel> movies = [];
  int id;

  PersonMovieModel({this.movies, this.id});

  PersonMovieModel.fromJson(Map<String, dynamic> json) {
    if (json['cast'] != null) {
      json['cast'].forEach((v) {
        movies.add(new MovieModel.fromJson(v));
      });
    }
    id = json['id'];
  }
}