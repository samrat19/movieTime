import 'package:movitm/logic/model/movie_model.dart';

class MovieResponse {
  List<MovieModel> movieList;
  int page;
  int totalPages;
  int totalResults;

  MovieResponse({
  this.movieList,this.page, this.totalPages, this.totalResults});

  MovieResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      movieList =  List<MovieModel>();
      json['results'].forEach((v) {
        movieList.add( MovieModel.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }
}