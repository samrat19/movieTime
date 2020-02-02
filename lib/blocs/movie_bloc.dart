import 'package:movitm/models/movie_model.dart';
import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc {
  final _repository = Repository();
  final _moviesFetcher = PublishSubject<MovieModel>();

  Observable <MovieModel> get allMovies => _moviesFetcher.stream;

  fetchAllMovies() async {
    MovieModel movieModel = await _repository.fetchAllMovies();
    _moviesFetcher.sink.add(movieModel);
  }

  dispose() {
    _moviesFetcher.close();
  }
}

final bloc = MoviesBloc();