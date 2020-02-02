import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:movitm/models/movie_model.dart';

class MovieApiProvider {
  Client client = Client();
  final _apiKey = 'e151ccdde6fbf9ea2d84c67dfb0a920c';

  Future<MovieModel> fetchMovieList() async {
    print("entered");
    final response = await client
        .get("http://api.themoviedb.org/3/movie/popular?api_key=$_apiKey");
    print(response.body.toString());
    if (response.statusCode == 200) {
      return MovieModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}