import 'movie_result.dart';

class MovieModel {
  int _page;
  int _totalResults;
  int _totalPages;
  List<MovieResult> _results = [];

  MovieModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['results'].length);
    _page = parsedJson['page'];
    _totalResults = parsedJson['total_results'];
    _totalPages = parsedJson['total_pages'];
    List<MovieResult> temp = [];
    for (int i = 0; i < parsedJson['results'].length; i++) {
      MovieResult _movieResult = MovieResult(parsedJson['results'][i]);
      temp.add(_movieResult);
    }
    _results = temp;
  }

  List<MovieResult> get results => _results;

  int get total_pages => _totalPages;

  int get total_results => _totalResults;

  int get page => _page;
}